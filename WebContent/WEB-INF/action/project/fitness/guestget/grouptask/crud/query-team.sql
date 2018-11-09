select 
	team_name as team_name,
	(select count(1) from hr_team_staff where team_id = hr_team.team_id) as teamnum
from hr_team
where team_id = ${fld:team_id} and org_id = ${def:org}