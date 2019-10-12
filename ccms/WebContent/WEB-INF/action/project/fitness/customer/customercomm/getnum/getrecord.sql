select
  concat('<input type="radio" class="duoxuan" name="datalist2"  value="',userlogin,'" >'    )as application_id,
name,

(SELECT COUNT(DISTINCT tuid)   FROM cc_return_log WHERE 
   s.userlogin=cc_return_log.followby and  cc_return_log.org_id=${def:org} GROUP BY followby)
as kefu1,

(SELECT COUNT(DISTINCT cc_comm.code)   FROM cc_return_log 
	left join cc_comm on cc_return_log.followby=cc_comm.createdby and cc_comm.org_id=${def:org}  	
WHERE 
   s.userlogin=cc_return_log.followby and  cc_return_log.org_id=${def:org}   GROUP BY cc_comm.createdby)
as kefu2

FROM hr_staff s 
inner join (select user_id from hr_staff_skill 
	inner join (
	select skill_id from hr_skill where 
	skill_scope in ('0')) skill on skill.skill_id = hr_staff_skill.skill_id
	) hs on hs.user_id = s.user_id
WHERE s.is_member = 0 AND s.status = 1 
AND s.org_id = ${def:org}
order by s.name_en
