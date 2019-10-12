INSERT INTO cc_feedback_follow(
	tuid,
	feedback_id,
	org_id,
	followstaff,
	actualfollowstaff,
	remark,
	nextfollowtime,
	nextfollowstaff,
	unfollow_reason,
	status,
	createdby,
	created,
	updatedby,
	updated,
	evalstar,
	evaltime
	) VALUES(
	${seq:nextval@seq_cc_feedback_follow},
	${fld:feedbackid},
	${def:org},
	${fld:mc},
	null,
	null,
	null,
	${fld:mc},
	null,
	1,
	'${def:user}',
	{ts '${def:timestamp}'},
	null,
	null,
	null,
	null
	)
	

