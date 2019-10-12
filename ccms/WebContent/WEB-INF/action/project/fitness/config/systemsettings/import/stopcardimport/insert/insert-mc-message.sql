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
    (select mc from cc_customer where code=${fld:customercode} and org_id = ${def:org}),   
    (select name from hr_staff where userlogin=
    (select mc from cc_customer where code=${fld:customercode} and org_id = ${def:org})),
    '您的会员'||(select name from cc_customer where code = ${fld:customercode} and org_id = ${def:org})||'办理停卡业务，停卡'||${fld:prestopdays}||'天',
    {ts'${def:timestamp}'},
    1,
    0,
    ${def:org}
)