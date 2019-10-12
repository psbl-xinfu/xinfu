insert into cc_operatelog
(
	code,--主键
	org_id,
	opertype,
	relatedetail,
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
	'54',
	${fld:cust_code}||';'||''||';'||''||';'||concat(${fld:moneycash}, '')||';'||concat(${fld:moneygift}, '')||';'||'',                                                  
	0,
	0,
	0,
	'${def:user}',
	${seq:currval@seq_cc_chargecard},
	1,
	${fld:pay_detail},--金额记录
	${fld:remark},
	'${def:date}',
	'${def:time}'
)

