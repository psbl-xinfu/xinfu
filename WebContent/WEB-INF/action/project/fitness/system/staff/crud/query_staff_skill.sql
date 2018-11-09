select 
	skill_id,
	skill_scope,
	skill_name 
from hr_skill 
where (
	(${fld:org_id} is not null and org_id = ${fld:org_id}) 
	or (${fld:org_id} is null and org_id = ${def:org})
) and (
	case when exists(
		select 1 from hr_staff_skill sk 
		inner join hr_skill k on sk.skill_id = k.skill_id 
		where sk.userlogin = '${def:user}' and k.skill_scope = '4' 
	) then true else skill_scope != '4' end 
)