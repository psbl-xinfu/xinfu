UPDATE cc_feedback_follow
 SET
	actualfollowstaff=${fld:actualfollowstaff},
	remark=concat(${fld:remark_1},${fld:remark_2}),
	nextfollowtime=${fld:nextfollowtime},
	nextfollowstaff=${fld:actualfollowstaff},
	unfollow_reason=${fld:unfollow_reason},
	status=${fld:status},
	updatedby='${def:user}',
	updated={ts '${def:timestamp}'}
WHERE feedback_id=${fld:feedback_id} 
AND created=(SELECT created FROM  cc_feedback_follow WHERE  feedback_id=${fld:feedback_id}  ORDER BY  created DESC LIMIT 1)
