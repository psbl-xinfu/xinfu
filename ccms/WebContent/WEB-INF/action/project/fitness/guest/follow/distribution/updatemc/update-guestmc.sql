update cc_guest
set mc = ${fld:mc}
where code = ${fld:id}
and org_id = ${def:org}
and (select status from cc_public where guestcode = ${fld:id} order by grabtime desc limit 1)
=0