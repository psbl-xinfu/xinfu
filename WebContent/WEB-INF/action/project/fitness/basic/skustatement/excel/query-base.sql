--zzn 按时间获取商品销售的数量及价格，单取商品库存量
select 
	lg.goodsid,
	cg.goods_name as goodsname,
	sum(lg.amount)::numeric(10, 0) as amount,
	round(sum(lg.factmoney)::numeric(10, 2), 2)as money,	
	cs.quantity::numeric(10, 0) as quantity,--库存总量
	round(cs.totalprice::numeric(10, 2), 2)as totalprice --库存总价
from cc_leave_stock_goods lg
left join cc_leave_stock ls on ls.tuid= lg.leave_stock_id and ls.org_id = lg.org_id
left join cc_goods cg on cg.tuid= lg.goodsid and cg.org_id = lg.org_id
left join cc_goods_stock cs on cs.goodsid=lg.goodsid and cs.org_id = lg.org_id
where lg.org_id = ${def:org}
and cs.status='1'
${filter}

group by goods_name ,lg.goodsid,cs.quantity,cs.totalprice