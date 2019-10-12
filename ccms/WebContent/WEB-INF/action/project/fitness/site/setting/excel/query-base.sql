select
	sd.sitename,
	(case when sd.status=1 then '空闲' when sd.status=0 then '无效' end) as status,
	concat(to_char(opening_date, 'HH24')::integer, '点') as opening_date,
	concat(to_char(closed_date, 'HH24')::integer, '点') as closed_date,
	(SELECT config.param_text FROM cc_config config WHERE config.CATEGORY = 'sitetype' and config.param_value::varchar = sd.sitetype
		and config.org_id = (case when not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end) ORDER BY config.tuid) as sitetype
from cc_sitedef sd
where sd.org_id = ${def:org}
${filter}
order by sd.created desc
