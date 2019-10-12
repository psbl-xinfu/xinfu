UPDATE cc_ptprepare 
SET 
	status = 2
WHERE code = ${fld:code} and org_id = ${def:org}
