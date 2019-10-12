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
	${fld:user_id},
    (select userlogin from hr_staff where user_id = ${fld:user_id} and org_id = ${def:org}),
	{ts '${def:timestamp}'},
	'${def:user}'
)
