select 
	gp.tuid as gptuid,
	goods.goods_name,
	(select storage_name from cc_storage where tuid = gp.storageid and org_id = ${def:org}) as storage_name 
from cc_goods_price gp
inner join cc_goods goods on gp.goodsid = goods.tuid and gp.org_id = goods.org_id
where gp.storageid = ${fld:storage_id} and gp.org_id = ${def:org}
and (goods.goods_name like concat('%', ${fld:goodsname}, '%') 
	or goods.fastcode like concat('%', ${fld:goodsname}, '%'))
and exists(
	select 1 from cc_goods_stock gs
	where gs.storageid = gp.storageid and gs.goodsid = gp.goodsid and gs.org_id = gp.org_id and gs.status = 1
)

