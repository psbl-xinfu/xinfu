insert into cc_thecontact
(
 	code
 	,guestcode
 	,name
 	,sex
 	,mobile
 	,position
	,createdby  --操作人
	,created  --操作时间
	,org_id
	,status
)
values 
(
	${seq:nextval@seq_cc_thecontact},
   	${fld:guestttcode},
	${fld:cc_name},
	${fld:cc_sex},
	${fld:cc_mobile},
	${fld:cc_position},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org},
	0
)


