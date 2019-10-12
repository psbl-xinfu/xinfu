insert into cc_message
(
    tuid,
    issystem,
    senduser,
    sendusername,
    recuser,
    recusername,
    content,
    sendtime,
    org_id
)
values 
(
	${seq:nextval@seq_cc_message},
  	  0,
	'${def:user}',
	(select name from hr_staff where userlogin=	'${def:user}'),
	${fld:code},
	(select name from cc_customer where code=${fld:code} and org_id=${def:org}),
	${fld:content},
	{ts '${def:timestamp}'},
    ${def:org}
)



