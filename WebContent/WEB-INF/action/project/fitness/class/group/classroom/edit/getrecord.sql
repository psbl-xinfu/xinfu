select
	code,
	classroom_name,
	area,
	room_type,
	limit_num,
	ispreparedevice,
	remark,
	status
from
	cc_classroom
where
	code=${fld:id} and org_id = ${def:org}
