select 
	concat('<input type="radio" name="goodsstocklist" value="', gs.tuid, '"/>') AS checklink,
	gs.quantity::int,
	gs.totalprice,
	s.storage_name,
	g.goods_name
from cc_goods_stock gs 
left join cc_goods g on gs.goodsid = g.tuid and gs.org_id = g.org_id
left join cc_storage s on gs.storageid = s.tuid and gs.org_id = s.org_id
where gs.status = 1 and gs.org_id = ${def:org}
${filter}
${orderby}


