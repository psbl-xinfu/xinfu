insert into cc_guest(
	code
	,officename
	,province2
	,city2
	,customtype
	,mc
	,officetel
	,email
	,officeaddr
	,createdby
	,created
	,org_id
) values(
	${fld:guestcode}
	,${fld:officename}
	,${fld:province}
	,${fld:city}
	,${fld:customtype}
	,${fld:mc}
	,${fld:officetel}
	,${fld:email}
	,${fld:officeaddr}
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,${def:org}
)