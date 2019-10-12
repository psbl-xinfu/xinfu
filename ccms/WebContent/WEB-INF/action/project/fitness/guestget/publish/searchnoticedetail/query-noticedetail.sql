select
	tuid,
	title,
	content,
	level,
	status,
	created
from cc_hkb_notice
where tuid = ${fld:tuid} and org_id = ${def:org}
