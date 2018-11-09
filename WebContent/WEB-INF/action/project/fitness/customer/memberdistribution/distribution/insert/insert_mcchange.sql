insert into cc_mcchange 
(
	code,
    customercode,
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
	${fld:customercode},
    (select mc from cc_customer where code = ${fld:customercode} and org_id = ${def:org}),
    ${fld:mc},
    1,
	{ts '${def:timestamp}'},
	'${def:user}',
	${def:org}
)