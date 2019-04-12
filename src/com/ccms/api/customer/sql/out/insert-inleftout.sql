insert into cc_inleft
(   
    code,--编号
	customercode,--会员编号：表e_customer主键
	--modified by leo 190401 自动入场不记录手牌
	--cabinettempcode,--手牌
	cardcode,--会员卡号：表e_card主键
	lefttime,--入场时间
	inuser,--入场操作人
	itemtype,--健身
	bringother,--带朋友入场
	signednumber,
	nowcount,
    org_id,--俱乐部编号
    type,---0成功1失败
    remark
)
values
(
	${seq:nextval@seq_cc_inleft},
	${fld:custcode},
	--modified by leo 190401 自动入场不记录手牌
	--(select tuid from cc_cabinettemp where cabinettempcode = ${fld:rudge_code} and 
	--org_id = ${fld:unionorgid}--${def:org}modified by leo 190328 使用传参数
	--),
	${fld:cardcode},
	'${def:timestamp}',
	${fld:deviceid}, -- modified by leo 190328
	0,
	0,
	1,
	(select nowcount from cc_card where
		code = ${fld:cardcode} AND isgoon = 0
		and org_id = ${fld:unionorgid}
		and exists(
		select 1 from cc_cardtype where org_id = ${fld:unionorgid}
		and code = cardtype
		and type = 1
		)
	),
	${fld:org},--${def:org}modified by leo 190328 使用传参数
	${fld:typet},
	${fld:remark}
)

