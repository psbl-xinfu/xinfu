select 
	concat(ht.team_name, (case when (select user_id from hr_staff 
		where userlogin = '${def:user}' and org_id = ${def:org})=ht.leader_id::int then '组长' else '组员' end)) as team_name
from hr_team_staff ts
left join hr_team ht on ts.team_id = ht.team_id
where ts.userlogin = '${def:user}'
and ht.org_id = ${def:org}