select
	(case when hs.skill_name='大队长' then '1' else '2' end) as usertype
from hr_skill hs
inner join hr_staff_skill ss on ss.skill_id = hs.skill_id
where hs.org_id = ${def:org} and ss.userlogin = '${def:user}'
limit 1