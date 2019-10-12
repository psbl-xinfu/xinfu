SELECT 
c_l.currentsecond
FROM et_course_log c_l
JOIN et_course_skill c_sk ON c_sk.tuid=c_l.course_skill_id
WHERE  c_l.userlogin='${def:user}' AND c_sk.courseid=${fld:courseid}  AND c_l.classid=${fld:classid} 
AND c_sk.status = 1 AND c_l.status != 0 

   