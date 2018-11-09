insert into cc_guest(
	code
	,name
	,mobile
	,mc
	,type
	,createdby
	,created
	,org_id
	,status
	,urgent
) values(
	${seq:nextval@seq_cc_guest}
	,${fld:name}
	,${fld:mobile}
	,${fld:mc}
	,7
	,'${def:user}'
	,${fld:created}::timestamp
	,${def:org}
	,99
	,${fld:othertel}
)