SELECT 
	s.term_score
FROM et_term_score s 
INNER JOIN et_course e ON s.termid = e.termid 
INNER JOIN et_class c ON c.courseid = e.tuid 
WHERE s.userlogin = '${def:user}' 
AND e.status = 1 AND c.status = 1 
AND EXISTS(
	SELECT 1 FROM et_course_log cg WHERE cg.courseid = e.tuid AND cg.classid = c.tuid AND cg.status = 2 
) 
ORDER BY s.term_date DESC LIMIT 1
