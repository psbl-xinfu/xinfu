select 
	h.userlogin,
	h.name
from 	hr_staff h
INNER JOIN (
select DISTINCT user_id  from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('0')  and org_id = ${def:org}
)as t  on t.user_id=h.user_id
where h.status = 1 
and h.org_id = ${def:org}