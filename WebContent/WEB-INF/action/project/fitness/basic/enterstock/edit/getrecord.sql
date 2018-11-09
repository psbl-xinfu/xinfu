select
	tuid,
	storageid,
	remark
from
	cc_enter_stock
where
	tuid=${fld:id} and org_id = ${def:org}
