select
	title,
	content,
	created
from cc_hkb_notice
where tuid = ${fld:tuid} and org_id = ${def:org}
