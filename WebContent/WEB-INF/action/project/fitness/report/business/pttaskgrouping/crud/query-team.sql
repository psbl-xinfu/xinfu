select 
	team_id,
	team_name,
	skill_scope
from
	hr_team
where skill_scope in ('1') and org_id=${def:org}