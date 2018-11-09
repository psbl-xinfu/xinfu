with paytype as (
	SELECT rowno::integer-1 AS rowno, param_text FROM (
		SELECT ROW_NUMBER() OVER() AS rowno, param_text, status FROM (
			SELECT param_text, status FROM cc_config WHERE CATEGORY = 'OtherPayWay' 
			and org_id = (case when 
				not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=cc_config.category) 
				then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end) 
			ORDER BY tuid
		) AS t1 
	) AS t2 WHERE status = 1
) 
SELECT 
	COALESCE((SELECT org_name FROM hr_org WHERE org_id = ${def:org} LIMIT 1),'') AS vc_club
	,t.createdate AS vc_contractdate
	,CASE WHEN t.contracttype = 1 OR t.contracttype = 2 OR t.type = 6 THEN '升级合同' 
		WHEN t.contracttype = 3 THEN '还款合同' 
		WHEN t.type = 5 THEN '定金合同' 	
		WHEN t.type = 0 THEN '办卡合同' 	
		WHEN t.type = 7 OR t.type = 9 OR t.type = 11 THEN '续卡合同' 	
		WHEN t.type = 10 THEN '转卡合同' 	
		WHEN t.type = 4 THEN '退卡合同' 	
		WHEN t.type = 2 THEN '私教合同' 	 
		WHEN t.type = 1 OR t.type = 12 THEN '租柜合同' ELSE '' END AS vc_contracttype
	,t.code AS vc_contractcode
	,t.billcode as vc_billcode
	,c.name as vc_name
	,CASE c.sex WHEN 0 THEN '女' WHEN 1 THEN '男' ELSE '未知' END AS sex
	,c.card as vc_idnumber
	,concat((select domain_text_cn from t_domain where "namespace"='Month' and domain_value = c.birth), '-', 
		(select domain_text_cn from t_domain where "namespace"='Day' and domain_value = c.birthday)) AS c_birthdate 
	,(select param_text from cc_config where param_value = c.nation and org_id = ${def:org} and CATEGORY = 'NATION') as vc_nation
	,c.addr as vc_addr
	,c.zip as vc_zip
	,'' AS vc_contact  
	,c.mobile as vc_mobile
	,c.officetel as vc_hometel
	,c.urgent as vc_emcontact1
	,'' as vc_emcontact2
	,c.code as vc_customcode
	,(SELECT name FROM hr_staff WHERE userlogin = t.salemember LIMIT 1) AS mcname
	,'' AS vc_rank
	,c.wx
	,c.qq
	,c.mc as vc_mc
	,d.startdate AS c_startdate /**20170110*/
	,d.code as vc_cardcode
	,d.enddate AS c_enddate /**20170110*/
	,'' AS vc_company /**20170110*/
	,'' AS vc_validdays /**20170110*/
	,concat(t.remark,dt.remark) AS vc_remark /**20170110*/
	,CASE d.starttype WHEN 0 THEN '当天启用' WHEN 1 THEN '初次训练启用' WHEN 2 THEN '固定时间启用' END AS vc_starttype
	,d.factmoney::numeric(10,2) AS yd_money
	,c.moneygift::numeric(10,2) AS zx_money
	,c.moneycash::numeric(10,2) AS xj_money
   ,(
		select string_agg(param_text,';')
		from paytype where 0.00 != (case when get_arr_value(f.pay_detail,rowno) = '' then '0.00' else get_arr_value(f.pay_detail,rowno) end)::numeric(10,2)
	) as vc_paytype
	,0.00::numeric(10,2) as memberfee
	,t.inimoney::numeric(10,2) as f_inimoney
	,t.normalmoney::numeric(10,2) as f_normalmoney
	,(t.inimoney - t.normalmoney)::numeric(10,2) AS f_discount
	,t.factmoney::numeric(10,2) as f_factmoney
	,(t.normalmoney - t.factmoney)::numeric(10,2) AS f_leftmoney
	,t.remark as vc_remark
	,(
		SELECT a.file_path FROM t_attachment_files a 
		WHERE a.table_code = 'cc_customer' AND a.pk_value = c.code 
		ORDER BY a.tuid DESC LIMIT 1
	) AS headpic 
	,'' AS customer_sign
	,dt.name as vc_cardtype
	,(select disclaimer from hr_org where org_id = ${def:org}) as disclaimer
FROM cc_contract t 
INNER JOIN cc_customer c ON t.customercode = c.code and t.org_id = c.org_id
LEFT JOIN cc_card d ON get_arr_value(t.relatedetail,1) = d.code AND d.isgoon = 0 and d.status != 0 and t.org_id = d.org_id
LEFT JOIN cc_cardtype dt ON d.cardtype = dt.code and d.org_id = dt.org_id
INNER JOIN cc_finance f ON t.billcode = f.code and t.org_id = f.org_id
WHERE t.code = ${fld:pk_value} AND t.status = 2 and t.org_id = ${def:org}




