SELECT
	config.tuid as sitedateid,
	config.param_value as sitedate_value
FROM
	cc_config config
WHERE
	config.category = 'Sitedate'
	and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)