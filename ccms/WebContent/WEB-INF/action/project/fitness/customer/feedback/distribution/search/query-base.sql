select 
  concat('<input type="radio" class="duoxuan" name="datalist"  value="',userlogin,'" >'    )as application_id,
name,

(SELECT COUNT(1)   FROM cc_feedback_follow WHERE 
   s.userlogin=cc_feedback_follow.followstaff  and  cc_feedback_follow.org_id=${def:org} and  status in (1, 2) GROUP BY followstaff)
as kefu1,

(SELECT COUNT(1)   FROM cc_feedback_follow WHERE 
   s.userlogin=cc_feedback_follow.followstaff  and  cc_feedback_follow.org_id=${def:org}  and  status=2 GROUP BY followstaff)
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
