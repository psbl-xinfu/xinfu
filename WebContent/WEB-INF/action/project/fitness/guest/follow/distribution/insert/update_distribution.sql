update
	cc_customer
SET
	mc = ${fld:mc},
	updated = {ts '${def:timestamp}'}
where
	code = ${fld:customercode} and org_id = ${def:org}