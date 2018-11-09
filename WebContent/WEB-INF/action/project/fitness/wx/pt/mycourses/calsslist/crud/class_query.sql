SELECT 
skill.tuid,
skill.groupid,
skill.courseid,
(select course_name from  et_course where tuid=skill.courseid )as course_name
FROM 
et_course_skill skill
 WHERE
groupid=${fld:id} 
AND EXISTS(
	SELECT 1 FROM hr_skill k 
	INNER JOIN hr_staff_skill sk ON sk.skill_id = k.skill_id 
	INNER JOIN hr_staff f ON f.user_id = sk.user_id 
	WHERE skill.skill_id = k.skill_id AND k.org_id = ${def:org} AND f.userlogin = '${def:user}'
) 
order by showorder
