SELECT 
q.tuid,
q.termid,
q.question_name,
q.question_code,
q.question_score,
CASE q.question_type 
WHEN 0 THEN '单选'
WHEN 1 THEN '多选'
ELSE '文本输入' END AS question_type,
q.showorder,
c.name AS createdby,
q.created,
u.name AS updatedby,
q.updated
FROM 
(et_term_question AS q
JOIN hr_staff AS c ON q.createdby=c.userlogin)
LEFT JOIN hr_staff AS u ON q.updatedby=u.userlogin
WHERE termid=${fld:termid}
${filter}
${orderby}
    
    
	