select 
	goods.tuid,
	goods.goods_name,
	goods.buyprice
from cc_goods goods
inner join cc_goods_price gp on goods.tuid = gp.goodsid and goods.org_id = gp.org_id
where goods.status = 1 and goods.org_id = ${def:org}
and gp.storageid = ${fld:storageid}

