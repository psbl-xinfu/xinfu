SELECT DISTINCT s.user_id, s.userlogin, s.name,s.name_en 
FROM hr_staff s 
inner join (select user_id from hr_staff_skill inner join 
	(select skill_id from hr_skill where skill_scope in ('1','4') and org_id = ${def:org}) skill
	on skill.skill_id = hr_staff_skill.skill_id
) hs on s.user_id = hs.user_id
WHERE 
s.is_member = 0 AND s.status = 1 
AND s.org_id = ${def:org}
order by s.name_en
