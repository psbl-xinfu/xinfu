update
	cc_guest
SET
	mc = ${fld:mc},
	updated = {ts'${def:timestamp}'}
where
	code = ${fld:id} and org_id = ${def:org}
