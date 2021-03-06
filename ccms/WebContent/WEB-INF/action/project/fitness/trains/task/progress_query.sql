SELECT
	v.courseid,
	COUNT(v.classid) 
FROM (
	SELECT DISTINCT g.classid, g.courseid  
	FROM et_class c 
	INNER JOIN et_resource r ON c.resourceid=r.tuid
	INNER JOIN et_course_log g ON g.courseid = c.courseid AND c.tuid = g.classid 
	INNER JOIN et_course e ON e.tuid = g.courseid 
	WHERE g.userlogin = '${def:user}' 
	AND c.status = 1 AND e.status = 1 AND g.status = 2 
) v 
GROUP BY v.courseid