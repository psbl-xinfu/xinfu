SELECT 
	code,
	name,
	mobile,
	guestcode,
	recommend as recommendcode,
	(select name from cc_customer where code = c.recommend and org_id = ${def:org}) as recommend,
	(select t.tuid from t_attachment_files t where t.pk_value = c.code 
	and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as custimgid
FROM cc_customer c 
WHERE code = ${fld:customercode} 
AND org_id = ${def:org} 
