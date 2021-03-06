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
    org_id,--俱乐部编号
    cardtype,-- zzn 增加刷卡的类型
    callparparecode,
    classdefcode
)
values
(
	${seq:nextval@seq_cc_inleft},
	${fld:cust_code},
	${fld:rudge_code},
	${fld:cardcode},
	{ts'${def:timestamp}'},
	'${def:user}',
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
	${def:org},
	${fld:cardtype},
	${fld:cpcode},
	(select code from  cc_classdef
	where code=(select classcode from cc_classlist where code=
	(select classlistcode from cc_classprepare where code =${fld:cpcode}))
	and org_id=${def:org}
	)
)

