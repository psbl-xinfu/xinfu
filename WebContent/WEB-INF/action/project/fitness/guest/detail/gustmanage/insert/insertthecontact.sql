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
   	${seq:currval@seq_cc_guest},
	${fld:cc_name},
	${fld:cc_sex},
	${fld:cc_mobile},
	${fld:cc_position},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org},
	(case when ${fld:ttstatus} = '0' then 0 
	when ${fld:ttstatus} = '1' then 1 else 0 end)
)


