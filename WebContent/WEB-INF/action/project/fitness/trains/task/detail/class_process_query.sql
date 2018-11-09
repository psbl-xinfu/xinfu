SELECT g.classid, max(g.status) AS status 
FROM et_class c 
INNER JOIN et_resource r ON c.resourceid=r.tuid
INNER JOIN et_course_log g ON g.courseid = c.courseid AND c.tuid = g.classid 
INNER JOIN et_course e ON e.tuid = g.courseid 
WHERE c.courseid = ${fld:courseid} AND g.userlogin = '${def:user}' 
AND c.status = 1 AND e.status = 1 AND g.status != 0 
GROUP BY g.classid
