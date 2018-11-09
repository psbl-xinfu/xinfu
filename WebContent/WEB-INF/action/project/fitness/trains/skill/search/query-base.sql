SELECT 
cs.tuid,
s.skill_name AS skill_name,
c.course_name AS course_name,
cs.begin_date,
cs.end_date,
cs.showorder,
cs.status,
cb.name AS createdby, 
cs.created,
ub.name AS updatedby,
cs.updated
FROM et_course_skill AS cs 
JOIN hr_skill AS s ON cs.skill_id=s.skill_id AND s.org_id = ${def:org} 
JOIN et_course AS c ON cs.courseid=c.tuid
LEFT JOIN hr_staff AS cb ON cs.createdby=cb.userlogin
LEFT JOIN hr_staff AS ub ON cs.updatedby=ub.userlogin
WHERE cs.status=1
${filter}
${orderby}
    
    
	