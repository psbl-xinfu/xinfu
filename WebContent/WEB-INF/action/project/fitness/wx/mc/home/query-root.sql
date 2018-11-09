select 
skill.skill_name
from 
hr_staff staff
inner join  hr_staff_skill  staff_skill on staff_skill.user_id=staff.user_id
inner join  hr_skill  skill on skill.skill_id=staff_skill.skill_id
WHERE staff.userlogin ='${def:user}'