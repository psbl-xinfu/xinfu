--如何只在储值卡办理时增加该记录 zzn  是否有必要加？
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
		(
		select COALESCE(e.moneyleft,0.00) from cc_cardtype e where e.code = (
			SELECT get_arr_value(t.relatedetail, 3) FROM cc_contract t WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} LIMIT 1
			) and e.org_id = ${def:org}
		),
		0,
		 (COALESCE(moneycash,0.00) + (
		select COALESCE(e.moneyleft,0.00) from cc_cardtype e where e.code = (
			SELECT get_arr_value(t.relatedetail, 3) FROM cc_contract t WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} LIMIT 1
			) and e.org_id = ${def:org}
		)),
		(
		select COALESCE(e.moneyleft,0.00) from cc_cardtype e where e.code = (
			SELECT get_arr_value(t.relatedetail, 3) FROM cc_contract t WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} LIMIT 1
			) and e.org_id = ${def:org}
		),
		'储值卡办理',
		1,
		'${def:user}',
	    {ts'${def:timestamp}'},
		${def:org}
	from cc_customer
	where code = (
			SELECT t.customercode FROM cc_contract t 	
			WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} LIMIT 1
		) AND org_id = ${def:org}
)
