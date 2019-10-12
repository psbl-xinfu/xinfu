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
	(case when (select customertype from cc_siteusedetail where code = ${fld:code} and org_id = ${def:org})=1 then 
		(select customercode from cc_siteusedetail where code = ${fld:code} and org_id = ${def:org}) else null
	end),
	(case when (select customertype from cc_siteusedetail where code = ${fld:code} and org_id = ${def:org})=1 then 
		(select name from cc_customer where code = 
		(select customercode from cc_siteusedetail where code = ${fld:code} and org_id = ${def:org}) and org_id = ${def:org}) else null
	end),
	concat('场地付款支付金额：', ${fld:normalmoney}),
	0,
	{ts'${def:timestamp}'},
	${def:org}
)



