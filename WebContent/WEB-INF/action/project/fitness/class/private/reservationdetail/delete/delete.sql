UPDATE cc_ptprepare 
SET 
	status = 0,
	updated = {ts '${def:timestamp}'},
	updatedby = '${def:user}' 
WHERE code = ${fld:id} and org_id = ${def:org}
