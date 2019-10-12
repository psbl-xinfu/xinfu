insert into cc_message
(
tuid,
issystem,
senduser,
sendusername,
recuser,  --kehubianhao
recusername,--kehuxingming
sendtime,
content,
status,
remind,
org_id
)
values 
(
	${seq:nextval@seq_cc_message},
	'0',
	 '${def:user}',
	  (select name from hr_staff where userlogin='${def:user}' ),
	    ${fld:mc_code},
 		(select name from cc_customer where code= ${fld:mc_code}),
	   {ts'${def:timestamp}'},
	     ${fld:mc_message},
	       '1',
	       '0',
	'${def:org}'
)