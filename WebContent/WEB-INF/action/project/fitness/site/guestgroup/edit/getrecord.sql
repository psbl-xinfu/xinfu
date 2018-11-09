select
	tuid,
	groupname
from
	cc_guest_group
where
	tuid::varchar=${fld:code} and org_id = ${def:org}
