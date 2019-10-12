select 
	staff.userlogin,
	staff.name 
from hr_staff staff
inner join (select ss.user_id from hr_staff_skill ss
		inner join (select skill_id from hr_skill where skill_scope = '8' and org_id = ${def:org}) skill
		on skill.skill_id = ss.skill_id
	) hs on staff.user_id = hs.user_id
where staff.status = 1 
and staff.org_id = ${def:org}

union

select 
	hss.userlogin,
	(select name from hr_staff where userlogin = hss.userlogin) as name
from hr_staff_skill hss
left join hr_staff hs on hs.userlogin = hss.userlogin
where isclass = 1 and hs.org_id = ${def:org}