UPDATE cc_customer
SET 
	moneycash = COALESCE(moneycash,0.00)-COALESCE(${fld:paymoney},0.00)
WHERE code = ${fld:customercode} AND org_id = ${def:org}
