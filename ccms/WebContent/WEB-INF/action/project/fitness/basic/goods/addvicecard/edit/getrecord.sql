select
	tuid,
	storageid,
	price,
	staff_price,
	remark
from
	cc_goods_price
where
	tuid=${fld:id} and org_id = ${def:org}
