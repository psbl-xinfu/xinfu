SELECT 
	code,
	name,
	mobile 
FROM cc_customer c 
WHERE code = ${fld:customercode} 
AND org_id = ${def:org}
