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
    org_id,--俱乐部编号
    inlefttype,
    signednumber
)
values
(
	${seq:nextval@seq_cc_inleft},
	${fld:cust_code},
	(select tuid from cc_cabinettemp where cabinettempcode = ${fld:rudge_code} and org_id = ${fld:unionorgid}),
	${fld:cardcode},
	{ts'${def:timestamp}'},
	'${def:user}',
	'${def:date}',
	0,
	0,
	${def:org},
	${fld:inlefttype},
	(case when (select expertype from cc_expercard where code=${fld:cardtype})=0 then 1 
	else ${fld:nowcount} end)
)

