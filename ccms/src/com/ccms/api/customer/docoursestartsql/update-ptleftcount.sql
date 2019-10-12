update
	cc_ptrest
SET
	ptleftcount = (ptleftcount-1)
where
	code = ${fld:ptrestcode} and org_id = ${fld:org}
