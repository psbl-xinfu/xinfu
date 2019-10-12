select
	tuid,
	cabinetcode
from cc_cabinet
where status = 0 and groupid=${fld:code} and org_id = ${def:org}
and physics_status = 1

