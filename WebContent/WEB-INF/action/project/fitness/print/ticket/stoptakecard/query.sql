SELECT 
	(SELECT org_name FROM hr_org WHERE org_id = ${def:org}) as vc_head
	,(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	  	and config.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as wish
	,p.code AS vc_billcode
	,p.cardcode as vc_cardcode
	,c.name as vc_name
	,p.startdate as c_startdate
	,p.prestopdays as i_prestopdays
	,p.money as f_money
	,s.name AS vc_iuser
	,to_char(p.created,'yyyy-MM-dd hh24:mi:ss') AS oper_time 
FROM cc_savestopcard p 
LEFT JOIN cc_customer c ON p.customercode = c.code and p.org_id = c.org_id 
LEFT JOIN hr_staff s ON p.createdby = s.userlogin 
WHERE p.code = ${fld:pk_value} and p.org_id = ${def:org}
