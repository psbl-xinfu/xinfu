SELECT
	config.tuid,
	config.param_text
FROM
	cc_config config
WHERE
	config.CATEGORY = 'sitetype'
and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
ORDER BY config.tuid

