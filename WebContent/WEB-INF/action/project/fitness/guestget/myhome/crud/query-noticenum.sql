select
	count(1) as noticenum
from cc_hkb_notice
where status = 1 and org_id = ${def:org}