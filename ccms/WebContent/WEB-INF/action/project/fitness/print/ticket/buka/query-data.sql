SELECT 
	(SELECT org_name FROM hr_org WHERE org_id = ${def:org}) as vc_head
  	,(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	  	and config.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as wish
	,f.code AS vc_billcode
	,get_arr_value(o.relatedetail, 1) AS old_cardcode
	,get_arr_value(o.relatedetail, 2) AS new_cardcode
	,c.name as vc_name
	,f.money as f_money
	,s.name AS vc_iuser
	,to_char(f.created,'yyyy-MM-dd hh24:mi:ss') AS oper_time 
FROM cc_finance f 
INNER JOIN cc_operatelog o ON o.code = f.operationcode and f.org_id = o.org_id
LEFT JOIN cc_customer c ON f.customercode = c.code and f.org_id = c.org_id
LEFT JOIN hr_staff s ON f.createdby = s.userlogin 
WHERE f.code = ${fld:pk_value} and f.org_id = ${def:org}
