select 
	staff.userlogin,
	staff.name 
from hr_staff staff
inner join (select ss.user_id from hr_staff_skill ss
		inner join (select skill_id from hr_skill where skill_scope in('2','4') and org_id = ${def:org}) skill
		on skill.skill_id = ss.skill_id
	) hs on staff.user_id = hs.user_id
where staff.status = 1 
and staff.org_id = ${def:org}

union

select 
	distinct so.userlogin,
	(select name from hr_staff where userlogin = so.userlogin) as name
from hr_staff_org so
where so.org_id = ${def:org} and so.userlogin = '${def:user}'
and exists(
		select 1 from hr_staff_skill sk 
		inner join hr_skill k on sk.skill_id = k.skill_id 
		where sk.user_id = so.user_id and k.skill_scope in ('2','4')
	) 
