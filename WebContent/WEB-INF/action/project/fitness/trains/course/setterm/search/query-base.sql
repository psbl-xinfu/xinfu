SELECT 
t.tuid,
t.term_name,
t.total_score,
t.standard_score,
t.status,
c.name AS createdby,
t.created,
u.name AS updatedby,
t.updated
FROM 
(et_term AS t
JOIN hr_staff AS c ON t.createdby=c.userlogin)
LEFT JOIN hr_staff AS u ON t.updatedby=u.userlogin
WHERE t.status=1
${filter}
${orderby}
    
    
	