insert into cc_operatelog
(
	code,--主键
	org_id,
	opertype,
	inimoney,
	normalmoney,
	factmoney,
	createdby,
	pk_value,
	status,
	pay_detail,
	remark,
	createdate,
	createtime
)
values 

(
	concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:nextval@seq_cc_operatelog}),	--主键
	${def:org},
	'80',
	0,
	0,
	0,
	'${def:user}',
	concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:currval@seq_cc_siteusedetail}),
	1,
	${fld:pay_detail},--金额记录
	${fld:remark},
	'${def:date}',
	'${def:time}'
)

