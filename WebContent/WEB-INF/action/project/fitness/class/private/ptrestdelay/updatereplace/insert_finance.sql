insert into cc_finance
(
	code,--主键
	customercode,--客户编号
	operatelogcode,
	operationcode,--操作主键
	salesman,--操作人
	type,--操作类型
	item,--chuzhi
	createdby,--操作人
	created,
	remark,--beizhu
	status,
	detail,
	premoney,
	money,
    pay_detail,
    org_id
)
values 
(
	${seq:nextval@seq_cc_finance},	--主键
    ${fld:custcode},--客户编号
	${seq:currval@seq_cc_operatelog},
	${seq:currval@seq_cc_ptrest_replace},--操作主键
	'${def:user}',--操作人
	2,--操作类型
	41,--chuzhi
	'${def:user}',
	{ts'${def:timestamp}'},
	${fld:remark},
	1,
	'更换课程'||';'||concat(${fld:ghfee}, '')||';'||concat(0, ''),
	${fld:ghfee},
	${fld:ghfee},
	${fld:pay_detail},
	${def:org}
)



