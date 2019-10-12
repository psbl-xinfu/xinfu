SELECT 
	CASE WHEN (
		select skill_scope from hr_skill where org_id = ${def:org} and skill_id in (select skill_id from hr_staff_skill where user_id = s.user_id)
	) = '1' THEN 'manager' ELSE '' END AS ismanager
FROM hr_staff s 
WHERE s.userlogin = '${def:user}'
