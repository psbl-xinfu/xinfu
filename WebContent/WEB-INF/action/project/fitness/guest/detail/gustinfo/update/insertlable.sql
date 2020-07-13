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
    ${fld:cc_code},
    ${fld:labels},
    '${def:user}',
    {ts '${def:timestamp}'},
	${def:org}
)
