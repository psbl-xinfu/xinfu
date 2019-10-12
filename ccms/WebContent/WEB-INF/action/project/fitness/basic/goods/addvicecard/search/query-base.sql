select 
	concat('<input type="checkbox" name="goodpricelist" value="', tuid, '" "/>') AS checklink,
	(select storage_name from cc_storage where tuid = storageid and org_id = ${def:org}) as storage_name,
	price,
	staff_price,
	remark
from cc_goods_price
where goodsid = ${fld:searchgoodsid} and org_id = ${def:org}
${filter}
${orderby}
