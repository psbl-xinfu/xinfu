SELECT COUNT(DISTINCT c_l.user_id) 
FROM et_course_log c_l 
WHERE c_l.status!=0 AND c_l.courseid=${fld:courseid}
