SELECT 
	code,
	name,
	mobile,
	recommend as recommendcode,
	(select name from cc_customer where code = c.recommend and org_id = ${def:org}) as recommend,
	(select t.tuid from t_attachment_files t where t.pk_value = c.code 
		and t.table_code = 'cc_guest' and t.org_id= ${def:org} order by t.tuid desc limit 1) as guestimgid
FROM cc_guest c 
WHERE code = ${fld:guestcode} 
AND org_id = ${def:org} 
