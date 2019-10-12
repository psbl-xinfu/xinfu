SELECT
	c.tuid,
	c.showorder,
	c.class_name,
	r.timelength,
	r.videourl,
	r.coverurl
FROM et_class c 
INNER JOIN et_resource r ON c.resourceid = r.tuid 
INNER JOIN et_course e ON e.tuid = c.courseid 
WHERE c.courseid = ${fld:courseid} AND c.status = 1 AND e.status = 1 
ORDER BY c.showorder
