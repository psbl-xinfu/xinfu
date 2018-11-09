UPDATE cc_guest 
SET 
	status = 99 
WHERE code = (
	SELECT guestcode FROM cc_customer WHERE code = (
		SELECT customercode FROM cc_contract WHERE code = ${fld:contractcode} AND org_id = ${def:org}
	) AND org_id = ${def:org}
) AND org_id = ${def:org} 
AND status != 99
