insert into cc_operatelog(
	code,
	opertype,--操作类型：对应域值OpeCategory
	relatedetail,--操作描述
	inimoney,--原价
	normalmoney,--应收
	factmoney,--实收
	status,--状态
	pay_detail,--支付明细
	remark,--备注
	createdby,--操作人
	createdate,--操作日期
	createtime,--操作时间
	customercode,--会员编号：cc_customer.code
	pk_value,--业务主键
	org_id
) (
	select
		${seq:nextval@seq_cc_operatelog},
		55,
		concat(${fld:custcode}, ';', ${fld:cardcode}, ';商品销售'),
		${fld:ystotal},
		${fld:paidupprice},
		(case when ${fld:othertype}  is null then 
			(case when ${fld:getmoney} is not null then ${fld:getmoney} else 0.00 end)
			else null
		end),
		1,
		${fld:pay_detail},
		'商品销售',
	    '${def:user}',
	    '${def:date}',
	    '${def:time}',
	    ${fld:custcode},
	    ${fld:leave_stockid},
		${def:org}
	from dual where ${fld:getmoney} is not null
)
