update cc_goods_stock gs
set quantity = gs.quantity+esg.amount,
		totalprice = gs.totalprice+esg.factmoney
from cc_goods_stock cgs
INNER JOIN cc_enter_stock_goods esg on cgs.goodsid = esg.goodsid and cgs.org_id = esg.org_id
INNER JOIN cc_enter_stock es on esg.enter_stock_id = es.tuid and esg.org_id = es.org_id
where cgs.storageid = es.storageid and gs.org_id = ${def:org} and cgs.org_id = ${def:org}
and gs.goodsid = esg.goodsid and gs.storageid = es.storageid
and es.tuid = ${fld:stocktuid}
