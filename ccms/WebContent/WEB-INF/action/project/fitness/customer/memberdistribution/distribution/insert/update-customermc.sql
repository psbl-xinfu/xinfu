update cc_customer
set mc = ${fld:mc},
updated = {ts '${def:timestamp}'}
where code = ${fld:customercode}
and org_id = ${def:org}
