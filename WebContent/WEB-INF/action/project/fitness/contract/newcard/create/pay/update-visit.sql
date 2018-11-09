UPDATE cc_guest_visit 
SET 
	contractcode = ${fld:contractcode},
	status = 3
WHERE code = (
	SELECT code FROM cc_guest_visit WHERE guestcode = (
		SELECT guestcode FROM cc_customer WHERE code = (
			SELECT customercode FROM cc_contract WHERE code = ${fld:contractcode} AND org_id = ${def:org} 
		) AND org_id = ${def:org} 
	) AND visitdate = '${def:date}'::date AND org_id = ${def:org} 
	and status!=0 and (contractcode is null or contractcode = '')
	ORDER BY created DESC LIMIT 1
) AND org_id = ${def:org} 
