select
	count(1) as monthguestnum
from cc_guest
where to_char(created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
and org_id = ${def:org} and status = 1

and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
		where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1)
		then 1=1 else createdby = '${def:user}' end)