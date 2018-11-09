update
	cc_ptprepare
SET
	status = 2
where
	code = ${fld:ptpcode} and org_id = ${def:org}
