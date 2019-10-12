insert into cc_mcchange 
(
	code,
    guestcode,
	oldmc,
	newmc,
	status,
	created,
	createdby,
	org_id
)
values 
(
	${seq:nextval@seq_cc_mcchange},
	${fld:id},
    (select mc from cc_guest where code = ${fld:id} and org_id = ${def:org}),
    ${fld:mc},
    1,
	{ts '${def:timestamp}'},
	'${def:user}',
	${def:org}
)