select 
	ht.team_id,
	'组长' as team_name 
from hr_team ht 
where ht.org_id = ${def:org} and exists(
	select 1 from hr_staff f where f.userlogin = '${def:user}' and ht.leader_id = f.user_id::varchar
) 

union 

select 
	ht.team_id,
	'组员' as team_name 
from hr_team ht 
where ht.org_id = ${def:org} and exists(
	select 1 from hr_team_staff ts where ts.userlogin = '${def:user}' and ts.team_id = ht.team_id 
) and not exists(
	select 1 from hr_staff f where f.userlogin = '${def:user}' and ht.leader_id = f.user_id::varchar
) 
