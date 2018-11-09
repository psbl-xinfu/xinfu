SELECT 
    e_s.term_question_id,
    coalesce(e_s.term_item_id,0) AS term_item_id,
    coalesce(e_s.remark,'NULL') AS remark,
    q.question_type
FROM et_term_question_score e_s 
    JOIN et_term_question q ON e_s.term_question_id=q.tuid

WHERE e_s.term_score_id=(
	SELECT t_s.tuid FROM  et_term_score t_s
	JOIN et_course c ON c.termid=t_s.termid
	WHERE t_s.userlogin='${def:user}' AND c.tuid=${fld:courseid} 
	ORDER BY t_s.term_date DESC limit 1)



   