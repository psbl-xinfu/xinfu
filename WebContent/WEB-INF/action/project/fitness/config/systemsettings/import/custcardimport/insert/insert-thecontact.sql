insert into cc_thecontact(
	code,
	guestcode,
	name,
	sex,
	mobile,
	position,
	createdby,
	created,
	org_id,
	status
) 
values
(
	${fld:thecode}
	,${fld:guestcode}
	,${fld:name}
	,${fld:sex}
	,${fld:mobile}
	,${fld:position}	
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,${def:org} 
	,${fld:status}
)

