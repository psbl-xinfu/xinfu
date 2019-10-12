SELECT 
	t_s.tuid
FROM  
	et_term_score t_s
 	JOIN et_course c ON c.termid=t_s.termid
WHERE t_s.userlogin='${def:user}' AND c.tuid=${fld:courseid} 
AND c.status = 1 


