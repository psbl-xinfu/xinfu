select
	tuid,
	storage_name,
	status,
	address
from
	cc_storage
where
	tuid=${fld:id} and org_id = ${def:org}
