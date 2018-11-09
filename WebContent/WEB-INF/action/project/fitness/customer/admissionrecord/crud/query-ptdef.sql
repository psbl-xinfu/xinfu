select 
   hr_staff.name
from 
   hr_staff LEFT JOIN hr_staff_skill ON hr_staff_skill.user_id = hr_staff.user_id
where hr_staff.staff_category in(1,2,4) and hr_staff.org_id = ${def:org}