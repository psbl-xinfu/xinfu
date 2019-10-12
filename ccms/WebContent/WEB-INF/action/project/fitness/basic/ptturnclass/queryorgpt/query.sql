select userlogin,name 
from hr_staff 
inner join (select user_id from hr_staff_skill 
	inner join (select skill_id from hr_skill where skill_scope in ('1', '4') and org_id = ${fld:org_id}) skill
	on skill.skill_id = hr_staff_skill.skill_id
) hs on hs.user_id = hr_staff.user_id
where status = 1 and org_id = ${fld:org_id}