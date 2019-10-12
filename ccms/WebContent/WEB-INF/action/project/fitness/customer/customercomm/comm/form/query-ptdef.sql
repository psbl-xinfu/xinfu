SELECT DISTINCT s.user_id, s.userlogin,  s.name_en,s.name
FROM hr_staff s 
inner join (select user_id from hr_staff_skill 
	inner join (
		select skill_id from hr_skill where 
		(case when ${fld:specialtype}='2' then skill_scope in ('1')
			else  skill_scope in ('2')
		end)) skill on skill.skill_id = hr_staff_skill.skill_id) hs on hs.user_id = s.user_id
WHERE 
s.is_member = 0 AND s.status = 1 
AND (
	s.org_id = ${def:org} 
)
order by s.name_en
