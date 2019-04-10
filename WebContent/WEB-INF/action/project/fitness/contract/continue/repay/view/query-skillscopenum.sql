SELECT 
	count(1) as skillscopenum
FROM 
	cc_config config
WHERE 
	config.category = 'SkillScope'
and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
and config.param_value like concat('%', (select skill_scope from hr_skill where skill_id in 
	(select skill_id from hr_staff_skill where userlogin = '${def:user}')), '%')