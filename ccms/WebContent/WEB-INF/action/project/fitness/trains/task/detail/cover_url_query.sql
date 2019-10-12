SELECT 
	r.coverurl
FROM  
	et_class c 
	JOIN et_resource r ON c.resourceid=r.tuid
WHERE c.courseid=${fld:courseid} AND c.status=1
ORDER BY c.showorder
LIMIT 1
