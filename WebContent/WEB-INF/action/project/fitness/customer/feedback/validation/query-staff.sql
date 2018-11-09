select 
	followstaff,
	(select name from hr_staff where userlogin = followstaff and org_id = ${def:org}) as staffname,
	status
from cc_feedback_follow
where org_id = ${def:org} and feedback_id = ${fld:feedbackid}
order by created desc LIMIT 1