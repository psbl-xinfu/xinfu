select
	tuid,
	title,
	(case when updated is null then created else updated end) as updated,
	'1' as type,
	'公告' as typename,
	created
from cc_hkb_notice
where status = 2 and org_id = ${def:org}

union 

select
	tuid,
	title,
	(case when updated is null then created else updated end) as updated,
	'2' as type,
	'话术' as typename,
	created
from cc_hkb_faq
where status = 2 and org_id = ${def:org}

order by created desc