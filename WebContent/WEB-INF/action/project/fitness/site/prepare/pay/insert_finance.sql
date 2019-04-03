insert into cc_finance
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
	concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:currval@seq_cc_siteusedetail}),--操作主键
	concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:currval@seq_cc_operatelog}),
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
	(case when 
		${fld:guesttype}::int=1 then  (select code from cc_customer where code=${fld:pkvalue})
		when ${fld:guesttype}::int=0 then (select code from cc_guest where code=${fld:pkvalue})
		when ${fld:guesttype}::int=3 then ('XG'||to_char({ts'${def:date}'},'yy')||lpad(${seq:currval@seq_cc_guest}::varchar, 6, '0'))::varchar
	end)
)



