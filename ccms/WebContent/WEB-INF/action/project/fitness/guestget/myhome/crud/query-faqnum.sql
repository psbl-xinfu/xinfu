select
	count(1) as faqnum
from cc_hkb_faq
where status = 1 and org_id = ${def:org}