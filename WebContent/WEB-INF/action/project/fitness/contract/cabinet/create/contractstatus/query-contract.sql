SELECT 
	c.status as contrstatus
FROM cc_contract c 
WHERE code = ${fld:contractcode} 
AND org_id = ${def:org}
