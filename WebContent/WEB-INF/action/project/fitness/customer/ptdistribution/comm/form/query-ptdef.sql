SELECT DISTINCT s.user_id, s.userlogin,  s.name_en,s.name
FROM hr_staff s 
WHERE 
s.user_id in (select user_id from hr_staff_skill where skill_id in(
	select skill_id from hr_skill where skill_scope in ('2', '4')
	and org_id = ${def:org}
))
AND s.is_member = 0 AND s.status = 1 
AND (
	s.org_id = ${def:org} 
)
order by s.name_en
