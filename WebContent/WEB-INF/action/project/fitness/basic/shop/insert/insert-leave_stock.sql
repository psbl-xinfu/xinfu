insert into cc_leave_stock(
	tuid,
	storageid,--仓库编号
	normalmoney,--应收金额
	factmoney,--实际金额
	getmoney,--收到金额
	status,--状态：0无效、1待确认、2已确认
	paystatus,--付款状态：1未付款、2已付款
	paytype,--支付方式：1现金/银行卡支付 2会员卡支付、3现金加会员卡
	customercode,--会员编号
	paycardcode,--支付卡号
	paycardmoneyleft,--会员卡支付前余额
	isguazhang,--是否挂账：0否、1是
	isstaff,--是否员工价：0否，1是
	pay_detail,--支付明细
	remark,--备注
	createdby,
	created,
	org_id,
	discount
) values(
	${fld:leave_stockid},
	${fld:storage_id},
	${fld:ystotal},
	${fld:paidupprice},
	(case when ${fld:othertype} is null then 
		(case when ${fld:getmoney} is not null then ${fld:getmoney} else 0.00 end)
	else null
	end),
	2,
	(case when ${fld:getmoney} is not null then 2 else 1 end),
	(case when ${fld:paydivgoodsinp}='f_chuzhika' and ${fld:paytheprice}::float=${fld:paidupprice}::float  then '2'::integer 
	when ${fld:paydivgoodsinp}='f_chuzhika' and ${fld:paytheprice}::float!=${fld:paidupprice}::float then '3'::integer
	when  ${fld:getmoney}::float=${fld:paidupprice}::float  then '1'::integer
	else null end),
	${fld:custcode},
	${fld:cardcode},
	(case when ${fld:paydivgoodsinp}='f_chuzhika' then (select moneycash from cc_customer where code = ${fld:custcode} and org_id = ${def:org})
	 else null
	end),
	(case when ${fld:othertype} is null then 0 else 1 end),
	${fld:staff_price},
	${fld:pay_detail},
	'商品销售',
    '${def:user}',
    {ts'${def:timestamp}'},
	${def:org},
	(case when ${fld:adiscount} is not null then ${fld:getmoney} else 0.00 end)
)
