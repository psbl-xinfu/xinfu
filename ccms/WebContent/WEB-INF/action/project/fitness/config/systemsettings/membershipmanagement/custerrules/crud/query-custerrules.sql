SELECT 
	config.tuid as day_id,
	config.param_value as day
FROM 
	cc_config config 
WHERE 
	config.category = 'GuestOutdate'
and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)