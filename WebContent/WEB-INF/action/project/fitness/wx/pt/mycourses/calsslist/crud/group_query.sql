SELECT
	(select remark  from  et_group g where skill.groupid=g.tuid    and g.status=1 and g.org_id=${def:org} )as remark,
	
	(select  coverurl  from et_resource r  
	inner join et_class e on e.resourceid=r.tuid where courseid=skill.courseid and e.status = 1 limit 1
	)as coverurl,
	
	(select  videourl  from et_resource r  
	inner join et_class e on e.resourceid=r.tuid where courseid=skill.courseid and e.status = 1 limit 1
	)as videourl

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
