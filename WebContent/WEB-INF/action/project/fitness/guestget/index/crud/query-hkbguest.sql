select
	code as tuid,
	name,
	mobile,
	sex,
	intention,
	(SELECT domain_text_cn FROM t_domain WHERE namespace = 'Age' and domain_value = age::varchar) as age
from cc_guest
where created::date = '${def:date}'::date
and status = 1 and org_id = ${def:org}
and createdby = '${def:user}'