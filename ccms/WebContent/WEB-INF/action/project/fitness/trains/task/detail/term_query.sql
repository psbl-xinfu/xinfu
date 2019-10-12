SELECT 
  q.tuid AS question_id,
  q.showorder AS question_order,
	q.question_name,
	q.question_score,
 (CASE q.question_type 
    WHEN 0 THEN '单选'
    WHEN 1 THEN '多选'
  ELSE '文本输入'
  END)  AS question_type,
	coalesce(i.tuid,0) AS item_id,
	coalesce(i.showorder,0) AS item_order,
    coalesce(i.item_name,'NULL') AS item_name,
    coalesce(i.item_score,0) AS item_score
FROM et_term_question q
 JOIN et_course c ON c.termid=q.termid
 LEFT JOIN et_term_item i ON i.questionid=q.tuid
WHERE c.tuid=${fld:courseid} AND c.status = 1 
ORDER BY q.showorder,i.showorder