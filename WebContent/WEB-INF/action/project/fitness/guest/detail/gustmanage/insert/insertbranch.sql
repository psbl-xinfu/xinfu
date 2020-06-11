insert into cc_branch
(
	code,
	guestcode,
	storename,
	address,
	created,
	createdby
)
values 
(
	${seq:nextval@seq_cc_branch},
    ${seq:currval@seq_cc_guest},
    ${fld:storename},
     ${fld:address},
    {ts '${def:timestamp}'},
    '${def:user}'
)
