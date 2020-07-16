insert into cc_branch
(
	code,
	guestcode,
	storename,
	address,
	created,
	createdby,
	states
)
values 
(
	${seq:nextval@seq_cc_branch},
    ${fld:guestcode},
    ${fld:storenameaddup},
     ${fld:addressaddup},
    {ts '${def:timestamp}'},
    '${def:user}',
    1
)
