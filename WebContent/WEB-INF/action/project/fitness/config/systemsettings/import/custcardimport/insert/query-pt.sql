select 
	staff.name as pt
from hr_staff staff
inner join (select ss.user_id from hr_staff_skill ss
		inner join (select skill_id from hr_skill where skill_scope in('1','4') and org_id = ${def:org}) skill
		on skill.skill_id = ss.skill_id
	) hs on staff.user_id = hs.user_id
where staff.org_id = ${def:org}
