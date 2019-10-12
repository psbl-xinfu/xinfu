insert into cc_message
(
   tuid,
   senduser,
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
    (select mc from cc_customer where code=${fld:vc_customercode} and org_id = ${def:org}),   
    (select name from hr_staff where userlogin=
    	(select mc from cc_customer where code=${fld:vc_customercode} and org_id = ${def:org})),
    '您的会员'||${fld:xvc_name}||'办理停卡业务，停卡'||${fld:ii_prestopdays}||'个月',
    {ts'${def:timestamp}'},
    1,
    0,
    ${def:org}
)