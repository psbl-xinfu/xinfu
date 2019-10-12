SELECT 
cl.tuid,
cl.class_name,
co.course_name,
re.videoname,
cl.showorder,
cl.status,
(case when cl.updatedby is null then st_c.name else st_u.name end) as updatedby,
(case when cl.updated is null then cl.created else cl.updated end) as updated
FROM 
((((et_class AS cl 
JOIN et_course AS co ON cl.courseid=co.tuid) 
JOIN et_resource AS re ON cl.resourceid=re.tuid)
JOIN hr_staff AS st_c ON cl.createdby=st_c.userlogin)
LEFT JOIN hr_staff AS st_u ON cl.updatedby=st_u.userlogin) 
WHERE (cl.status=1 AND cl.courseid=${fld:courseid})
${filter}
${orderby}
    
    
	