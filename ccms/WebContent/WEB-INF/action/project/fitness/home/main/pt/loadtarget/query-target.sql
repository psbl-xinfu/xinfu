SELECT 
	COALESCE(s.allclass_target,0) AS allclass_target
	,COALESCE(s.unpayclass_target,0) AS unpayclass_target
	,COALESCE(s.call_pt_target,0) AS call_pt_target
	,COALESCE(s.orderfee_target,0) AS orderfee_target 
FROM cc_target_staff s 
INNER JOIN cc_target_group g ON g.tuid = s.targetgroupid AND s.org_id = g.org_id 
WHERE g.target_year = to_char({ts '${def:timestamp}'}, 'yyyy')::integer 
AND g.target_month = to_char({ts '${def:timestamp}'}, 'MM')::integer 
AND s.userlogin = '${def:user}' AND g.org_id = ${def:org} 
and g.target_type = (SELECT config.param_value::int FROM
	cc_config config WHERE config.category = 'Taskgoal'
	and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end))
ORDER BY g.tuid LIMIT 1
