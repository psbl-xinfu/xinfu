UPDATE cc_ptprepare 
SET 
	status = 0,
	updated = {ts '${def:timestamp}'},
	updatedby = '${def:user}' 
WHERE code = ${fld:code} and org_id = ${def:org}
