insert into cc_inleft
(   
    code,--编号
	customercode,--会员编号：表e_customer主键
	intime,--入场时间
	inuser,--入场操作人
	indate,--入场日期
	itemtype,--健身
	bringother,--带朋友入场
	signednumber,
    type,---0成功1失败
    remark
)
values
(
	${seq:nextval@seq_cc_inleft},
	${fld:custcode},
	'${def:timestamp}',
	${fld:deviceid}, -- modified by leo 190328
	'${def:date}',
	0,
	0,
	1,
	${fld:typet},
	${fld:remark}
)

