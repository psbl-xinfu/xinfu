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
	${seq:nextval@seq_cc_operatelog},	--主键
	${def:org},
	'80',
	0,
	0,
	0,
	'${def:user}',
	${fld:code},
	1,
	concat('0;0;0;0;0;', ${fld:normalmoney}, ';0;'),
	${fld:remark},
	'${def:date}',
	'${def:time}'
)

