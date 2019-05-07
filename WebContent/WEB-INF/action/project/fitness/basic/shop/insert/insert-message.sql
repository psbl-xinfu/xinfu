insert into cc_message(
	tuid,
	issystem,--消息类型：0互动消息、1系统消息、2合同审批提醒、3储物柜到期提醒
	senduser,--发送人
	sendusername,--发送人姓名
	recuser,--接收人
	sendtime,--发送时间
	recusername,--接收人姓名
	content,--消息内容
	status,--状态：0无效、1正常
	remind,--提醒：0不提醒、1需提醒、2已提醒
	org_id
) (
	select 
		${seq:nextval@seq_cc_message},
		1,
	    '${def:user}',
	    (select name from hr_staff where userlogin = '${def:user}' and org_id = ${def:org}),
	    ${fld:custcode},
	    {ts'${def:timestamp}'},
	    (select name from cc_customer where code = ${fld:custcode} and org_id = ${def:org}),
	    '购买商品',
	    1,
	    1,
		${def:org}
	from dual where ${fld:getmoney} is not null
)
