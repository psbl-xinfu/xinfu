insert into cc_label_the
(
	code,
	thecode,
	labelcode,
	createdby,
	created,
	org_id
)
values 
(
	${seq:nextval@seq_cc_label_the},
    ${seq:currval@seq_cc_thecontact},
    ${fld:labelname},
    '${def:user}',
    {ts '${def:timestamp}'},
	${def:org}
)
