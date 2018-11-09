INSERT INTO et_course_log 
VALUES(${seq:nextval@seq_et_course_log},
	   null,
	   ${fld:courseid},
	   ${fld:classid},
	   1,
	   0,
	   '${def:user}', 
	   {ts '${def:timestamp}'},
	   null,
	   null,
	   ${fld:course_skill_id},
	   ${fld:skill_id},
	   (select user_id from hr_staff where userlogin='${def:user}'),
	   '${def:user}'
)