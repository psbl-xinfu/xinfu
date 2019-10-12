select userlogin,name from hr_staff where status = 1  and is_member = 0 and org_id = ${def:org} 
union
select userlogin,name from hr_staff s where status = 1 and is_member = 0 
and (
	case when exists(
		select 1 from hr_staff_skill sk 
		inner join hr_skill k on sk.skill_id = k.skill_id 
		inner join hr_staff sf on sf.user_id = sk.user_id 
		where k.skill_scope = '1' and k.data_limit = 1 and sf.org_id = ${def:org} 
	) then exists(
		select 1 from hr_staff_skill sk 
		inner join hr_skill k on sk.skill_id = k.skill_id 
		where sk.user_id = s.user_id and k.skill_scope = '1' 
		and k.org_id = s.org_id 
	) else false end
) 
and org_id = ${def:org}
