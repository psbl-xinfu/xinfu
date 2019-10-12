insert into cc_message
(
   tuid,
   senduser,
   recuser,
   recusername,
   content,
   sendtime,
   org_id
)
values 
(
	${seq:nextval@seq_cc_message},
    '${def:user}',
    ${fld:customercode},
    ${fld:cust_name},
    '办理解挂业务，会员卡恢复正常使用',
    {ts'${def:timestamp}'},
    ${def:org}
)

