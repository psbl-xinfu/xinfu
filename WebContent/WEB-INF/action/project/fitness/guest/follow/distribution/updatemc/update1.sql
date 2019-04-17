update cc_public
set grabtime={ts'${def:timestamp}'},
oldfollow= (select newfollow from cc_public where guestcode= ${fld:id} and org_id = ${def:org}),
newfollow= ${fld:mc}
where guestcode = ${fld:id}
and org_id = ${def:org}
