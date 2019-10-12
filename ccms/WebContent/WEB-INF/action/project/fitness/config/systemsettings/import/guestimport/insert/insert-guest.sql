insert into cc_guest(
	code
	,name
	,sex
	,mobile
	,mc
	,age
	,type
	,createdby
	,created
	,org_id
) values(
	${seq:nextval@seq_cc_guest}
	,${fld:name}
	,${fld:sex}
	,${fld:mobile}
	,${fld:mc}
	,${fld:age}
	,${fld:type}
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,${def:org}
)