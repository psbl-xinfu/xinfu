select
name,
h.user_id,
(case when r.skill_scope='1' then '私教' else '会籍' end) as type
from 
hr_staff h
inner join hr_staff_skill   k on  k.user_id=h.user_id 
inner join hr_skill r on k.skill_id=r.skill_id
where 
h.userlogin=${fld:recuser}
and h.org_id=${def:org}