insert into cc_inleft
(   
    code,--编号
	customercode,--会员编号：表e_customer主键
	--modified by leo 190401 自动入场不记录手牌
	--cabinettempcode,--手牌
	intime,--入场时间
	inuser,--入场操作人
	indate,--入场日期
	itemtype,--健身
	bringother,--带朋友入场
	signednumber,
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
	'${def:timestamp}',
	${fld:deviceid}, -- modified by leo 190328
	'${def:date}',
	0,
	0,
	1,
	${fld:org},--${def:org}modified by leo 190328 使用传参数
	${fld:typet},
	${fld:remark}
)

