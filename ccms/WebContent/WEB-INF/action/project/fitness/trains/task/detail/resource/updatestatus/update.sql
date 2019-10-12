UPDATE et_course_log
SET status=2,
   updatedby='${def:user}',
   updated={ts '${def:timestamp}'},
   course_skill_id = (select tuid from et_course_skill where courseid=${fld:courseid} and status = 1 
   		and skill_id = (select skill_id from hr_staff_skill where userlogin = '${def:user}')),
   skill_id = (select skill_id from et_course_skill 
   		where courseid=${fld:courseid} and status = 1 and skill_id = (select skill_id from hr_staff_skill where userlogin = '${def:user}')),
    user_id = (select user_id from hr_staff where userlogin = '${def:user}' and org_id = ${def:org}),
    userlogin = '${def:user}'
WHERE userlogin = '${def:user}' AND classid=${fld:classid} AND  status!=0
  


   