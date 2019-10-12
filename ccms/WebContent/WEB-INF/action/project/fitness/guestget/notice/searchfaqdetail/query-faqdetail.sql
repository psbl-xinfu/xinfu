select
	title,
	content,
	created
from cc_hkb_faq
where tuid = ${fld:tuid} and org_id = ${def:org}
