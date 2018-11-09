INSERT INTO et_course_log(
		tuid,
        course_staff_id,
        courseid,
        classid,
        status,
        currentsecond,
        createdby,
        created,
        updatedby,
        updated,
        course_skill_id,
        skill_id,
        user_id,
        userlogin
)VALUES(
		${seq:nextval@seq_et_course_log},
		(SELECT c_st.tuid FROM et_course_staff c_st
			JOIN et_course_skill c_sk ON c_st.course_skill_id=c_sk.tuid
		WHERE c_st.userlogin='${def:user}' AND c_sk.courseid=${fld:courseid}
		AND c_st.status = 1 AND c_sk.status = 1 ),
		${fld:courseid},
		${fld:classid},
		1,
		0,
		'${def:user}',
		{ts '${def:timestamp}'},
		null,
		null,
		(select min(tuid) from et_course_skill where courseid=${fld:courseid} and status = 1 
			and skill_id = (select skill_id from hr_staff_skill where userlogin = '${def:user}')),
		(select min(skill_id) from et_course_skill where courseid=${fld:courseid} and status = 1 
			and skill_id = (select skill_id from hr_staff_skill where userlogin = '${def:user}')),
		(select user_id from hr_staff where userlogin = '${def:user}' and org_id = ${def:org}),
		'${def:user}'
)
  


   