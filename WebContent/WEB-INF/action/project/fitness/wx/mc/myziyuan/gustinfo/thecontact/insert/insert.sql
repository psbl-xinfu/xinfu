insert into cc_thecontact
(
 	code
 	,guestcode
 	,name
 	,sex
 	,mobile
 	,positioncode
	,createdby  --操作人
	,created  --操作时间
	,org_id
	,status
	,birthday
)
values 
(
	${seq:nextval@seq_cc_thecontact},
   	${fld:guestcode},
	${fld:thename},
	${fld:sex},
	${fld:cc_mobile},
	${fld:position},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org},
	0,
	${fld:birthday}
)


