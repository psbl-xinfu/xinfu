UPDATE cc_guest 
SET 
	status = 80,
	mc = null 
WHERE code = ${fld:guestcode} AND org_id = ${fld:org_id}