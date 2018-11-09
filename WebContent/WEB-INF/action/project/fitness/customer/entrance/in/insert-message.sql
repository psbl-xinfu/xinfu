insert into cc_message
(   
    tuid,
	senduser,
    sendusername,
	recuser,
	recusername,
	content,
	sendtime,
	status,
	remind,
	org_id
)
values
(
	${seq:nextval@seq_cc_message},
	'${def:user}',
	'${def:user}',
	${fld:cust_code},
	${fld:cust_name},
	'健身区域前台入场',
	{ts'${def:timestamp}'},
	1,
	0,
	${def:org}
)









