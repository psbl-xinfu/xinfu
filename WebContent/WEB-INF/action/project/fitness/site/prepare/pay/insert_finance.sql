insert1 into cc_finance
(
	code,--主键
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
    org_id,
    customercode
)
values 
(
	${seq:nextval@seq_cc_finance},	--主键
	${seq:currval@seq_cc_operatelog},
	concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:nextval@seq_cc_siteusedetail}),--操作主键
	'${def:user}',--操作人
	3,--操作类型
	36,--chuzhi
	'${def:user}',
	{ts'${def:timestamp}'},
	${fld:remark},
	1,
	'场地押金付款',
	${fld:yyinputprice},
	${fld:deposit},
	${fld:pay_detail},
	${def:org},
	(case when (select customertype from cc_siteusedetail where code = concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:nextval@seq_cc_siteusedetail}) and org_id = ${def:org}) in (1,2) then 
		(select customercode from cc_siteusedetail where code = concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:nextval@seq_cc_siteusedetail}) and org_id = ${def:org}) else null
	end)
)



