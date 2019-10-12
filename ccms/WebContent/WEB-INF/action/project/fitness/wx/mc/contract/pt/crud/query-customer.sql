SELECT 
	code,
	name,
	mobile,
	(SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =c.user_id
		 )as headpic
FROM cc_customer c 
WHERE code = ${fld:customercode} 
AND org_id = ${def:org}
