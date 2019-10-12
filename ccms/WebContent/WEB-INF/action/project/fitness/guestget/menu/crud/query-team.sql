select 
	team_id,
	team_name
from hr_team
where status = 1 and org_id = ${def:org}
order by team_id desc
