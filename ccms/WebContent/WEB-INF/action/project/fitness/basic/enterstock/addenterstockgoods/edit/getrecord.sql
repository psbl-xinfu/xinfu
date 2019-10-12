select
	tuid,
	enter_stock_id,
	goodsid,
	amount,
	price,
	money,
	factmoney,
	remark
from
	cc_enter_stock_goods
where
	tuid=${fld:id} and org_id = ${def:org}
