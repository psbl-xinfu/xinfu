insert into cc_finance
(
	code,--主键
	customercode,--客户编号
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
    ${fld:cust_code},--客户编号
	${seq:currval@seq_cc_chargecard},--操作主键
	'${def:user}',--操作人
	3,--操作类型
	11,--chuzhi
	'${def:user}',
	{ts'${def:timestamp}'},
	${fld:remark},
	1,
	'退费'||';'||concat((${fld:moneycash}*-1.00), '')||';'||'',
	(${fld:moneycash}*-1.00),
	0,
	${fld:fushu},
	${def:org}
)



