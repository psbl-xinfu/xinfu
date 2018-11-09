insert into cc_leave_stock_goods(
	tuid,
	leave_stock_id,
	goodsid,--商品编号
	amount,--商品数量
	price,--商品单价
	money,--商品总金额
	factmoney,--实际金额
	remark,--
	org_id
) values(
	${seq:nextval@seq_cc_leave_stock_goods},
	${fld:leave_stockid},
	${fld:goodid},
	${fld:goodsnum},
	${fld:price},
	(${fld:goodsnum}::integer*${fld:price}::float),
	${fld:tdmoney},
	'商品销售',
	${def:org}
)
