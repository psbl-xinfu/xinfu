--把
UPDATE cc_ptprepare 
SET 
	status = 2
WHERE code = ${fld:reservationID} and org_id = ${fld:org}
