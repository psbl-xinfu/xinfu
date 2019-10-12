update cc_guest
set level = ${fld:level}
where (case when ${fld:guestcode} is null then 1=2 else code = ${fld:guestcode} end)
and org_id = ${def:org}