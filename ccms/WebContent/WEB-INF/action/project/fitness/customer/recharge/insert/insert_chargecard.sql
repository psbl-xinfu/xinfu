insert into cc_chargecard
(
	code,--主键
	customercode,--客户编号
	issellnewcard,--是否
    restmoney,--充前余额
	chargemoney,--本次充值金额
	givemoney,--本次赠送金额
	totalmoney,--充后余额
	factmoney,--实际充值
	remark,--user
   	status,
	createdby,
	created,
   	org_id
)
 
(
	select
		${seq:nextval@seq_cc_chargecard},	
		code,
		0,
		moneycash,
		${fld:moneycash},
		${fld:moneygift},
		moneycash+${fld:moneycash},
		${fld:moneycash},
		${fld:remark},
		1,
		'${def:user}',
	    {ts'${def:timestamp}'},
		${def:org}
	from cc_customer
	where code = ${fld:cust_code} and org_id = ${def:org}
)



