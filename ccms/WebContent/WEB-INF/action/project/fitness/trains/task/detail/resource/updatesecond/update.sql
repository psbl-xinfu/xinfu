UPDATE et_course_log
SET currentsecond=${fld:currentsecond},
   updatedby='${def:user}',
   updated={ts '${def:timestamp}'},
   course_skill_id = (
		select cs.tuid from et_course_skill cs where cs.courseid = ${fld:courseid} and (
			exists(select 1 from et_course_staff cf where cs.tuid = cf.course_skill_id and cf.userlogin = '${def:user}')
			or exists(select 1 from hr_staff_skill sk where sk.skill_id = cs.skill_id and sk.userlogin = '${def:user}')
		) and cs.status = 1
   ),
   skill_id = (
		select cs.skill_id from et_course_skill cs where cs.courseid = ${fld:courseid} and (
			exists(select 1 from et_course_staff cf where cs.tuid = cf.course_skill_id and cf.userlogin = '${def:user}')
			or exists(select 1 from hr_staff_skill sk where sk.skill_id = cs.skill_id and sk.userlogin = '${def:user}')
		) and cs.status = 1
   ),
    user_id = (select user_id from hr_staff where userlogin = '${def:user}' and org_id = ${def:org}),
    userlogin = '${def:user}'
WHERE userlogin = '${def:user}' AND classid=${fld:classid} AND  status!=0
  


   