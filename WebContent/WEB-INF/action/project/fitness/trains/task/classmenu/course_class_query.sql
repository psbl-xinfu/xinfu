SELECT 
  c.courseid,
  c.tuid AS classid,
  c.class_name,
  r.tuid AS resourceid,
  r.coverurl,
  (select count(1) from et_course_log g where g.classid = c.tuid and c.resourceid = r.tuid and g.userlogin = '${def:user}'
		and g.status=1 and g.courseid = ${fld:courseid}) as numone,
  (select count(1) from et_course_log g where g.classid = c.tuid and c.resourceid = r.tuid and g.userlogin = '${def:user}'
		and g.status=2 and g.courseid = ${fld:courseid}) as numtwo
FROM et_class c 
INNER JOIN et_resource r ON r.tuid=c.resourceid 
INNER JOIN et_course e ON c.courseid = e.tuid 
WHERE c.courseid=${fld:courseid} AND c.status=1 AND e.status = 1 
ORDER BY c.showorder





