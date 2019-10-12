SELECT DISTINCT
  c_l.classid
FROM et_course_log c_l 
INNER JOIN et_class c ON c.tuid = c_l.classid 
WHERE c_l.userlogin='${def:user}' AND c_l.status=2 AND c_l.courseid=${fld:courseid} 
AND c.status = 1 
