update cc_public
set
grabtime={ts'${def:timestamp}'},
oldfollow= (select newfollow from cc_public where customercode = ${fld:customercode} and org_id = ${def:org}),
newfollow= ${fld:mc}
where customercode = ${fld:customercode}
and org_id = ${def:org}
