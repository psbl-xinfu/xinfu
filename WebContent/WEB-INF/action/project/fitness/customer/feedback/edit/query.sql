SELECT  c.name,
		f.customercode,
		f.fbtype,
		f.isanonymous,
		f.complainttype,
		f.complaint_userid,
		f.complaint_skill,
		f.complaint_item,
		f.complaint_envir,
		f.fbremark,
		f_f.remark,
		f_f.status,
		(select name from hr_staff where userlogin = f_f.updatedby) as actualfollowstaff,
		f_f.updated
	FROM cc_feedback f
	LEFT JOIN cc_feedback_follow f_f ON f.tuid=f_f.feedback_id
	LEFT JOIN cc_customer c ON f.customercode=c.code
	WHERE f.tuid=${fld:id};
   