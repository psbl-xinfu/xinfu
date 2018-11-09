SELECT 
	c_g.groupid,
	g.groupname AS groupname,
 	c_g.courseid AS courseid,
	c.course_name AS course_name,
	c_sk.showorder
FROM et_course_staff c_st
INNER JOIN et_course_skill c_sk ON c_st.course_skill_id = c_sk.tuid
INNER JOIN et_course_group  c_g ON c_g.courseid = c_sk.courseid
INNER JOIN et_group g ON c_g.groupid = g.tuid
INNER JOIN et_course  c ON  c_g.courseid = c.tuid
WHERE c_st.status = 1 AND c_st.userlogin = '${def:user}' and c_sk.begin_date <= '${def:date}'::date and c_sk.end_date >= '${def:date}'::date 
AND c.status = 1 AND g.status = 1 AND c_st.status = 1 AND c_sk.status = 1 AND g.status = 1 AND c_g.status = 1 

union

SELECT 
	cg.groupid,
	g.groupname,
 	c_sk.courseid AS courseid,
	c.course_name AS course_name,
	c_sk.showorder
FROM hr_staff_skill ss
INNER JOIN et_course_skill c_sk ON ss.skill_id = c_sk.skill_id
INNER JOIN et_course_group cg on cg.courseid = c_sk.courseid
INNER JOIN et_group g ON cg.groupid = g.tuid
INNER JOIN et_course  c ON  c_sk.courseid = c.tuid
WHERE ss.userlogin = '${def:user}' and c_sk.begin_date <= '${def:date}'::date and c_sk.end_date >= '${def:date}'::date 
AND c.status = 1 AND g.status = 1 AND cg.status = 1 AND c_sk.status = 1 AND g.status = 1 

order by groupid,showorder
