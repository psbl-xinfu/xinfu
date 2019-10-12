SELECT 
	c_l.classid,
	COUNT(c_l.classid) AS times
FROM et_course_log c_l 
INNER JOIN et_course e ON c_l.courseid = e.tuid 
INNER JOIN et_class c ON c_l.classid = c.tuid 
WHERE c_l.status=2 AND c_l.courseid=${fld:courseid} 
AND e.status = 1 AND c.status = 1 
GROUP BY c_l.classid
