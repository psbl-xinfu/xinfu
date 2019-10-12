with paytype as (
	SELECT rowno::integer-1 AS rowno, vc_content FROM (
		SELECT ROW_NUMBER() OVER() AS rowno, vc_content, i_useravailable FROM (
			SELECT vc_content, i_useravailable FROM E_CNFG WHERE VC_CATEGORY = 'OtherPayWay' ORDER BY cnfg_id
		) AS t1 
	) AS t2 WHERE i_useravailable = '1'
)
SELECT 
	t.vc_code	-- 合同号
	,t.vc_name	-- 姓名
	,CASE WHEN t.i_contracttype = 1 OR t.i_contracttype = 2 OR t.i_type = 6 THEN get_arr_value(r.vc_relatecode, 1) 	/** 升级合同 */
		WHEN t.i_contracttype = 3 THEN get_arr_value(r.vc_relatecode, 1) 	/** 还款合同 */
		WHEN t.i_type = 5 THEN get_arr_value(r.vc_relatecode, 1) 	/** 定金合同 */
		WHEN t.i_type = 0 THEN get_arr_value(r.vc_relatecode, 1) 	/** 办卡合同 */
		WHEN t.i_type = 7 OR t.i_type = 9 OR t.i_type = 11 THEN get_arr_value(r.vc_relatecode, 1) 	/** 续卡合同 */
		WHEN t.i_type = 10 THEN get_arr_value(r.vc_relatecode, 1) 	/** 转卡合同 */
		WHEN t.i_type = 4 THEN get_arr_value(r.vc_relatecode, 1) 	/** 退卡合同 */
		WHEN t.i_type = 2 THEN get_arr_value(r.vc_relatecode, 6) 	/** 私教合同 */ 
		WHEN t.i_type = 1 OR t.i_type = 12 THEN get_arr_value(r.vc_relatecode, 11)/** 租柜合同 */ ELSE '' END AS vc_cardcode	-- 卡号
	,CASE WHEN t.i_contracttype = 1 OR t.i_contracttype = 2 OR t.i_type = 6 THEN '升级  '
			||COALESCE((SELECT vc_name FROM e_cardtype WHERE vc_code=get_arr_value(r.vc_relatecode, 27) LIMIT 1),'')
			||' 到 '||get_arr_value(r.vc_relatecode, 9) 	/** 升级合同 */
		WHEN t.i_contracttype = 3 THEN (
			CASE WHEN t.i_type = 0 THEN '办卡合同还款' || COALESCE(t.vc_relatecode,'') /* 办卡合同还款 */
				WHEN t.i_type = 5 THEN '定金合同还款' || COALESCE(t.vc_relatecode,'') /* 定金合同还款 */
				WHEN t.i_type = 2 THEN '私教合同还款  ' || COALESCE(t.vc_relatecode,'') /* 私教合同还款 */
				WHEN t.i_type = 1 THEN '续租柜合同还款  ' || COALESCE(t.vc_relatecode,'') /* 续租柜合同还款 */
				WHEN t.i_type = 12 THEN '租柜合同还款  ' || COALESCE(t.vc_relatecode,'') /* 租柜合同还款 */
				WHEN t.i_type = 10 THEN '转卡合同还款  ' || COALESCE(t.vc_relatecode,'') /* 转卡合同还款 */
				WHEN t.i_type = 7 OR t.i_type = 9 OR t.i_type = 11 THEN '续卡合同还款  ' || COALESCE(t.vc_relatecode,'') /* 续卡合同还款 */
				ELSE '' END
		) 	/** 还款合同 */
		WHEN t.i_type = 5 THEN '定金  '||COALESCE(get_arr_value(r.vc_relatecode, 9),'') 	/** 定金合同 */
		WHEN t.i_type = 0 THEN '办卡  '||COALESCE(get_arr_value(r.vc_relatecode, 9),'') 	/** 办卡合同 */
		WHEN t.i_type = 7 OR t.i_type = 9 OR t.i_type = 11 THEN '续卡 ' || get_arr_value(r.vc_relatecode, 19)	/** 续卡合同 */
		WHEN t.i_type = 10 THEN '转卡' 	/** 转卡合同 */
		WHEN t.i_type = 4 THEN '退卡' 	/** 退卡合同 */
		WHEN t.i_type = 2 THEN (
			SELECT 
				'私教 '||COALESCE(d.vc_ptlevelname,'')||' '||COALESCE(d.f_ptfee,0)||'元  '||COALESCE(get_arr_value(r.vc_relatecode, 2),'')||'节'
			FROM e_ptdef d 
			WHERE d.vc_code = get_arr_value(r.vc_relatecode, 1) 
		) 	/** 私教合同 */ 
		WHEN t.i_type = 1 OR t.i_type = 12 THEN '租柜  '||get_arr_value(r.vc_relatecode, 1)||' 租期'||get_arr_value(r.vc_relatecode, 2)||'个月'/** 租柜合同 */ ELSE '' END AS vc_detail	-- 业务说明
	,r.f_inimoney	-- 原价
	,r.f_normalmoney	-- 应收
	,r.f_factmoney     --实收
	,t.i_discounttype	-- 折扣
	,(f_inimoney-f_normalmoney)  as  f_discountmoney ---折扣金额
	,u.name AS vc_iusername	-- 录入人
	,t.c_idate	-- 录入日期
	,t.c_itime	-- 录入时间
	,t.i_status
	,CASE t.i_status WHEN 1 THEN '未付款' WHEN 2 THEN '已付款' WHEN 4 THEN '已审核' END AS status_desc 
	,t.i_type
	,t.i_contracttype
	,(
		CASE WHEN t.i_type = 1 OR t.i_type = 12 THEN (
			 (CASE WHEN get_arr_value(r.vc_relatecode, 5) = '' THEN '0.00' ELSE get_arr_value(r.vc_relatecode, 5) END)::numeric(10,2)
		) ELSE 0.00::numeric(10,2) END
	) AS f_deposit	-- 租柜合同押金
	,t.vc_billcode	-- 收据号（表e_finance主键）
	,f.f_pos   --刷卡金额
	,f.vc_auser
    ,f.c_atime
	,COALESCE(t.i_stage_times,0) AS i_stage_times
	,COALESCE(t.i_stage_times_pay,0) AS i_stage_times_pay 
	,(SELECT tenantry_name FROM t_tenantry WHERE tenantry_id = ${def:tenantry}) as vc_club
	,(SELECT vc_content as wish FROM e_cnfg WHERE vc_category = 'Wish') as jieshuyu
	,(
		select string_agg(vc_content||'：'||get_arr_value(f.pay_detail,rowno),'<br/>') 
		from paytype
	) as paydetail
FROM e_contract t 
LEFT JOIN e_finance f ON t.vc_billcode = f.vc_code 
LEFT JOIN hr_staff u ON t.vc_iuser = u.userlogin 
INNER JOIN e_contractrow r ON t.vc_code = r.vc_code 
INNER JOIN e_customer c ON r.vc_customcode = c.vc_code 
INNER JOIN e_card d ON c.vc_code = d.vc_customercode AND d.i_isgoon = 0 and d.i_status != 0 
INNER JOIN e_cardtype dt ON d.vc_cardtype = dt.vc_code 
WHERE t.vc_code = ${fld:pk_value}

