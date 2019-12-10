insert into cc_label_guest
(
	code,
	guestcode,
	labelcode,
	createdby,
	created,
	org_id
)
values 
(
	${seq:nextval@seq_cc_label_guest},
    ${seq:currval@seq_cc_guest},
    ${fld:labels},
    '${def:user}',
    {ts '${def:timestamp}'},
	${def:org}
)
