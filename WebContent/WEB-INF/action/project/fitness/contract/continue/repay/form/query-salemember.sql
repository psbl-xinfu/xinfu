select distinct s.user_id, s.userlogin, s.name, s.name_en 
from hr_staff s 
where exists(
	select 1 from hr_staff_skill sk 
	inner join hr_skill k on sk.skill_id = k.skill_id 
	where sk.user_id = s.user_id and k.skill_scope in ('2','4')
) 
and s.is_member = 0 and s.status = 1 
and s.org_id = ${def:org} 

union

select 
	distinct so.user_id,
	so.userlogin,
	(select name from hr_staff where userlogin = so.userlogin) as name,
	(select name from hr_staff where userlogin = so.userlogin) as name_en
from hr_staff_org so
where so.org_id = ${def:org} and so.userlogin = '${def:user}'
and exists(
		select 1 from hr_staff_skill sk 
		inner join hr_skill k on sk.skill_id = k.skill_id 
		where sk.user_id = so.user_id and k.skill_scope in ('2','4')
	) 

