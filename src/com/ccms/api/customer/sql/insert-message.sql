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
	${fld:deviceid},
	${fld:deviceid},
	${fld:uid},
	${fld:membersName},
	'健身区域前台入场',
	'${def:timestamp}',
	1,
	0,
	${fld:org}--${def:org} modified by leo 190328
)









