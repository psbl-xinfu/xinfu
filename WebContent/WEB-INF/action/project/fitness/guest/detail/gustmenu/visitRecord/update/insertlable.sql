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
    ${fld:cc_code},
    ${fld:labelname},
    '${def:user}',
    {ts '${def:timestamp}'},
	${def:org}
)
