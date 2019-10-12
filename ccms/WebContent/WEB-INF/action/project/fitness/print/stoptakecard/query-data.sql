SELECT 
	(SELECT org_name FROM hr_org WHERE hr_org.org_id = ${def:org}) as vc_head
	,(SELECT vc_content as wish FROM e_cnfg WHERE vc_category = 'Wish') as wish
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
