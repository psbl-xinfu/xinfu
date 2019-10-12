SELECT
	(cf.param_value::integer*31) as stopcardnum
FROM
	cc_config cf
WHERE
	cf.category = 'MaxStopMonth'
and 
	cf.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=cf.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)