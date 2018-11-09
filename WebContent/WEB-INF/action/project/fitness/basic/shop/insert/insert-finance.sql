insert into cc_finance(
	code,
	cardcode,--会员卡号
	customercode,--客户编号
	operatelogcode,--操作日志cc_operatelog主键编号
	type,--收入类型：1会员卡、2私教、3杂项。对应t_domain域值FinanceType
	item,--类型补充说明：10办卡、11储值、12升级、13续卡、20私教、30未分类、31储物柜、32转卡、33单次消费、34商品销售、34场地、35团操。对应t_domain域值FinanceItem
	detail,--操作说明
	premoney,--预付款
	money,--收入
	moneyleft,--欠款金额
	remark,--备注
	status,--状态
	pay_detail,--支付明细
	salesman,--销售人
	createdby,
	created,
	org_id
) (
	select
		${seq:nextval@seq_cc_finance},
		${fld:cardcode},
		${fld:custcode},
		${seq:currval@seq_cc_operatelog},
		3,
		34,
		'商品销售',
		${fld:ystotal},
		${fld:total},
		0,
		'商品销售',
		1,
		${fld:pay_detail},
	    '${def:user}',
	    '${def:user}',
	    {ts'${def:timestamp}'},
		${def:org}
	from dual where ${fld:othertype}!='3'
)


