select 
	gp.tuid as gptuid,
	goods.goods_name
from cc_goods_price gp
inner join cc_goods goods on gp.goodsid = goods.tuid and gp.org_id = goods.org_id
where gp.storageid = ${fld:storage_id} and gp.org_id = ${def:org}
and exists(
	select 1 from cc_goods_stock gs
	where gs.storageid = gp.storageid and gs.goodsid = gp.goodsid and gs.org_id = gp.org_id and gs.status = 1
)

