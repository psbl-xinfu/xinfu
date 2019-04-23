SELECT
	finance.code as vc_code	-- 收据号
	,(
		CASE WHEN t.code IS NOT NULL AND t.code != '' THEN 
			(SELECT hs.name FROM hr_staff hs WHERE hs.userlogin = t.salemember and hs.org_id = t.org_id) 
		ELSE (SELECT hs.name FROM hr_staff hs WHERE hs.userlogin = finance.salesman and hs.org_id = finance.org_id) END
	) AS sv_salesname	-- 销售
	,(
		CASE WHEN t.code IS NOT NULL AND t.code != '' THEN 
			(SELECT hs.name FROM hr_staff hs WHERE hs.userlogin = t.salemember1 and hs.org_id = t.org_id) 
		ELSE '' END
	) AS sv_salesname2	-- 销售
	,finance.cardcode as vc_cardcode	-- 卡号
	,cust.name AS vc_customername	-- 姓名
	,finance.type as vc_type
	,(select domain_text_cn from t_domain where "namespace"='FinanceItem' and domain_value = finance.item::varchar) AS vc_typename	-- 收入类型
	,(case when finance.type=1 then '会员卡' when finance.type=2 then '私教' when finance.type=3 then '杂项' end) as categories
	,finance.detail as vc_detail	-- 收入类型
	,finance.premoney as f_premoney	-- 预付款
	,(
		CASE WHEN  finance.type = '3' AND EXISTS(
			SELECT 1 FROM cc_singleitem m WHERE m.code = finance.operationcode 
			AND m.isguazhang = 1 AND m.status = 1 and m.org_id = finance.org_id
		) THEN 0 ELSE finance.money END
	) AS f_money	-- 收入
    ,(case when t.stage_times>1 then '0' else finance.moneyleft end) as f_moneyleft-- 欠款
	,staff.name AS vc_ausername	-- 收银
	,finance.created::date AS c_adate	-- 收银日期
	,finance.remark as vc_remark	-- 备注
	,finance.operationcode as vc_operationcode
	,finance.item as vc_item
	,ol.opertype as caozuo_zhujian
	,finance.pay_detail 
FROM cc_finance finance 
LEFT JOIN cc_customer cust on finance.customercode = cust.code and finance.org_id = cust.org_id
LEFT JOIN hr_staff staff on finance.createdby = staff.userlogin and finance.org_id = staff.org_id
LEFT JOIN cc_ptdef ptdef on finance.ptlevelcode = ptdef.code and finance.org_id = ptdef.org_id
LEFT JOIN cc_operatelog ol on finance.operationcode = ol.pk_value and finance.org_id = ol.org_id and ol.opertype != '29' ---排除租柜押金
LEFT JOIN cc_contract t on finance.operationcode = t.code and finance.org_id = t.org_id and t.status >= 2 
WHERE /** 普通会籍只能查看自己的会员合同 */
1=1
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else staff.userlogin = '${def:user}' end)

and finance.org_id = ${def:org}
AND finance.status = 1 
and (CASE when ${fld:daochu_salename_query} is not null then (case when ${fld:daochu_salename_query}='3' then 
	 	(case when ${fld:daochu_yewuleixing} is not null then (case when ${fld:daochu_yewuleixing}='1001' then 1=2 else 1=1 end) else 1=1 end) else 1=1
	 end) else 1=1 end)

${filter}

union 

select 
	s.code as vc_code 
	,(select name from hr_staff where userlogin = s.createdby) AS sv_salesname
	,null AS sv_salesname2
	,s.cardcode as vc_cardcode
	,cust.name AS vc_customername
	,s.stoptype as vc_type
	,CASE s.stoptype WHEN '1' THEN '存卡' WHEN '2' THEN '停卡' WHEN '3' THEN '特殊停卡' END AS vc_typename -- 收入类型
	,'杂项' as categories
	,null -- 收入类型
	,0 -- 预付款
	,s.money AS f_money --收入
	,0 as f_moneyleft
	,staff.name AS vc_ausername	-- 收银
	,s.collecttime::date AS c_adate	-- 收银日期
	,null
	,null
	,null
	,null as caozuo_zhujian
	,concat(s.money::varchar,';','0;','0;','0;','0;','0;')
from cc_savestopcard s
LEFT JOIN cc_customer cust on s.customercode = cust.code and s.org_id = cust.org_id
LEFT JOIN hr_staff staff on s.createdby = staff.userlogin
where s.created::date >= ${fld:daochu_start_date}
	 and s.created::date <= ${fld:daochu_end_date}
	 and money !=0 and s.org_id = ${def:org}
	 and (CASE when ${fld:daochu_salename_query} is not null then (case when ${fld:daochu_salename_query}='3' then 
	 	(case when ${fld:daochu_yewuleixing} is not null then (case when ${fld:daochu_yewuleixing}='1001' then 1=1 else 1=2 end) else 1=1 end) else 1=2
	 end) else 1=1 end)
and (case when ${fld:daochu_shouyinyuan} is null then 1=1 else s.collectby=${fld:daochu_shouyinyuan} end)
and (case when ${fld:daochu_xiaoshouyuan} is null then 1=1 else s.createdby=${fld:daochu_xiaoshouyuan} end)

ORDER BY c_adate DESC