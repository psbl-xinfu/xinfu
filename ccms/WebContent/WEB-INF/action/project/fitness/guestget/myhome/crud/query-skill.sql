select
	(case when hs.skill_name='大队长' then '1' 
		when hs.skill_name='组员' and (select count(1) from hr_team 
		where org_id = ${def:org} and leader_id::int = 
			(select user_id from hr_staff 
				where userlogin = '${def:user}' and org_id = ${def:org}))>0
		then '2'
		else '3' end) as usertype
from hr_skill hs
inner join hr_staff_skill ss on ss.skill_id = hs.skill_id
where hs.org_id = ${def:org} and ss.userlogin = '${def:user}'
limit 1