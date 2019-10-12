insert into hr_staff_org
(
	tuid,
	org_id,
	user_id,
	userlogin,
    created,
    createdby
)
values 
(
	${seq:nextval@seq_hr_staff_org},
	${fld:stores},
	${seq:currval@${schema}seq_user},
    ${fld:userlogin},
	{ts '${def:timestamp}'},
	'${def:user}'
)
