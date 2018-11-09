select
	tuid,
	title,
	content,
	status,
	created
from cc_hkb_faq
where tuid = ${fld:tuid} and org_id = ${def:org}
