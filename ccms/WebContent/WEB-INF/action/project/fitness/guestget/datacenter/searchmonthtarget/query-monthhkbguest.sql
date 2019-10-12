select 
	count(1) as monthguestnum
from cc_guest
where to_char(created::date, 'yyyy-MM') = to_char(${fld:monthdateinfo}::date, 'yyyy-MM')
and org_id = ${def:org} and status = 1
and createdby in 
	(select userlogin from hr_team_staff 
		where (case when ${fld:team_id} is null then 1=1 else team_id = ${fld:team_id} end))