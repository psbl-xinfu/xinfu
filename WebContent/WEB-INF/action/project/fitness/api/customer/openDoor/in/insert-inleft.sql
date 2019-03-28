insert into cc_inleft
(   
    code,--编号
	customercode,--会员编号：表e_customer主键
	cabinettempcode,--手牌
	cardcode,--会员卡号：表e_card主键
	intime,--入场时间
	inuser,--入场操作人
	indate,--入场日期
	itemtype,--健身
	bringother,--带朋友入场
	signednumber,
	nowcount,
    org_id--俱乐部编号
)
values
(
	${seq:nextval@seq_cc_inleft},
	${fld:cust_code},
	(select tuid from cc_cabinettemp where cabinettempcode = ${fld:rudge_code} and 
	org_id = ${fld:unionorgid}--${def:org}modified by leo 190328 使用传参数
	),
	${fld:cardcode},
	{ts'${def:timestamp}'},
	'开发接口测试1', -- modified by leo 190328
	'${def:date}',
	0,
	0,
	(case when (select type from cc_cardtype where code=${fld:cardtype})=0 then 1 
	else ${fld:nowcount} end),
	(select nowcount from cc_card where
		code = ${fld:cardcode} AND isgoon = 0
		and org_id = ${fld:unionorgid}
		and exists(
		select 1 from cc_cardtype where org_id = ${fld:unionorgid}
		and code = cardtype
		and type = 1
		)
	),
	${fld:unionorgid}--${def:org}modified by leo 190328 使用传参数
)

