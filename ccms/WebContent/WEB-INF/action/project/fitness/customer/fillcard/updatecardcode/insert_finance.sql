insert into cc_finance
(
	salesman,
	code,
	cardcode,
	customercode,
	operationcode,--操作主键
	type,
	item,
	detail,
	money,
	createdby,
   	created,
	status,
	pay_detail,
	org_id
)
values 
(
'${def:user}',
	${seq:currval@seq_cc_finance},
   	${fld:vc_code},
   	${fld:in_bianhao},
   	COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'')||${seq:currval@seq_cc_operatelog},--操作主键
   	1,
	40,
	'补卡',
	${fld:bukafei},
   		'${def:user}',
   		{ts'${def:timestamp}'},
   	1,
   	${fld:pay_detail},
   	${def:org}
)


