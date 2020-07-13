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
    ${seq:currval@seq_cc_guest},
    ${fld:storename},
     ${fld:address},
    {ts '${def:timestamp}'},
    '${def:user}',
    (case  when ${fld:states}='1'  then 1 else 0 end)
)
