insert into cc_message(
	tuid,
	issystem,
	recuser,
	recusername,
	sendtime,
   	status,
   	remind,
	org_id
)
values 
(
	${seq:nextval@seq_cc_message},
	1,
	${fld:customercode},
	${fld:cust_name},
    {ts'${def:timestamp}'},
    1,
    1,
    ${def:org}
)
