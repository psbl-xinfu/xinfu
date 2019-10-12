select
	ts.userlogin,
	(select name from hr_staff where userlogin = ts.userlogin and org_id = ${def:org}) as username
from hr_team tm
inner join hr_team_staff ts on tm.team_id = ts.team_id
where tm.org_id = ${def:org} 
and leader_id::int = (select user_id from hr_staff where userlogin = '${def:user}' and org_id = ${def:org})
