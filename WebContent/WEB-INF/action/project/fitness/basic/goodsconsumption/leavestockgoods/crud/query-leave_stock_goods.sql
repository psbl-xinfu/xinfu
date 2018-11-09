select
	goods.goods_name,
	goods.standard,
	(select	domain_text_cn from t_domain where "namespace"='goodUnit' and domain_value = goods.unit and is_enabled = '1' ) as unit,
	lsg.price,
	lsg.amount::int,
	lsg.factmoney
from cc_leave_stock_goods lsg
left join cc_goods goods on lsg.goodsid = goods.tuid and lsg.org_id = goods.org_id
where
	lsg.leave_stock_id=${fld:tuid} and lsg.org_id = ${def:org}
