UPDATE cc_customer 
SET 
	moneyleft = (COALESCE(moneyleft,0.00) + (${fld:normalmoney} - ${fld:factmoney})) 
WHERE code = (
	SELECT DISTINCT customercode FROM cc_contract 
	WHERE code = ${fld:contractcode} AND org_id = ${def:org} LIMIT 1
) AND org_id = ${def:org}
