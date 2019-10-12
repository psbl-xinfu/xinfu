insert into cc_message
(
	tuid,--主键
	senduser,--记录人
	sendusername,--记录人姓名
	recuser,--客户编号
	recusername,--客户姓名
	content,--操作内容
	status,--
	sendtime,
	org_id
)
values 
(
	${seq:nextval@seq_cc_message},	
	'${def:user}',
	'${def:user}',
	${fld:cust_code},
	${fld:name},
	'会员充值'||concat(${fld:moneycash}, '')||'元，充值同时并且赠送了您'||concat(${fld:moneygift}, '')||'元',
	0,
	{ts'${def:timestamp}'},
	${def:org}
)



