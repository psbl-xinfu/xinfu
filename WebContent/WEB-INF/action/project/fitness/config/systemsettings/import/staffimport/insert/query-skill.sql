select 
	skill_name as skill
from hr_skill 
where org_id = ${def:org} and (
	case when exists(
		select 1 from hr_staff_skill sk 
		inner join hr_skill k on sk.skill_id = k.skill_id 
		where sk.userlogin = '${def:user}' and k.skill_scope = '4' 
	) then true else skill_scope != '4' end 
)