SELECT 
i.tuid,
i.questionid,
i.item_name,
i.item_score,
i.showorder,
c.name AS createdby,
i.created,
u.name AS updatedby,
i.updated
FROM 
(et_term_item AS i
JOIN hr_staff AS c ON i.createdby=c.userlogin)
LEFT JOIN hr_staff AS u ON i.updatedby=u.userlogin
WHERE i.questionid=${fld:questionid}
${filter}
${orderby}
    
    
	