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
    ${fld:customercode},
    ${fld:cust_name},
    '办理停卡业务，停卡'||${fld:prestopdays}||'天',
    {ts'${def:timestamp}'},
    1,
    0,
    ${def:org}
)

