update
	cc_ptrest
SET
	ptleftcount = (ptleftcount-1)
where
	code = ${fld:restcode} and org_id = ${def:org}
