SELECT 
	c.course_name,
	COUNT(c.course_name) AS class_amount
FROM et_course c 
INNER JOIN et_class cl ON cl.courseid = c.tuid 
WHERE c.tuid = ${fld:courseid} AND c.status = 1 AND cl.status = 1 
GROUP BY c.course_name