UPDATE cc_customer 
SET 
	moneyleft = (COALESCE(moneyleft,0.00) - ${fld:factmoney}) 
WHERE code = (
	SELECT t.customercode FROM cc_contract t 
	WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} LIMIT 1
) AND org_id = ${def:org}
