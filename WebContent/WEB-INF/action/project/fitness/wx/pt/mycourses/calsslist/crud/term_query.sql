SELECT
(select termid from  et_course where tuid=skill.courseid )as termid,
(select course_name from  et_course where tuid=skill.courseid )as course_name,

(select total_score from et_term where 
	tuid=(select termid from  et_course where tuid=skill.courseid )
)as total_score,

(select term_score from et_term_score where 
	tuid=(select termid from  et_course where tuid=skill.courseid )
)as term_score,
skill.courseid,
skill.end_date
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
