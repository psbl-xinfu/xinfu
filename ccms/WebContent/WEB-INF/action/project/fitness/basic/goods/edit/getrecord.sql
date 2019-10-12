select
	tuid,
	goods_name,
	fastcode,
	goods_type,
	standard,
	unit,
	buyprice,
	isgift,
	remark
from
	cc_goods
where
	tuid=${fld:id} and org_id = ${def:org}
