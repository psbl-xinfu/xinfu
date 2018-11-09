insert into cc_message    
(
    tuid,           
    issystem,         
    templateid,       
    senduser,
    sendusername,
    sendtime,
    content,
    remind,
    status,
    org_id
)
values
(
	${seq:nextval@seq_cc_message},
	'0',
	'1060',
	'${def:user}',
	(select name from hr_staff where userlogin='${def:user}'),
	{ts'${def:timestamp}'},
	replace((select content from cc_msg_template where templatename = 'SJ_FPJL'),'$$教练名称$$',(select name from hr_staff where userlogin=${fld:pt})),
	(select remind  from  cc_msg_template  where  templatename = 'SJ_FPJL'),
	'1',
	'${def:org}'
)



