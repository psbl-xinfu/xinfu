INSERT INTO cc_feedback(
	tuid,
	org_id,
	customercode,
	fbtype,
	isanonymous,
	complainttype,
	complaint_userid,
	complaint_skill,
	complaint_item,
	complaint_envir,
	fbremark,
	status,
	createdby,
	created
	) VALUES(
	${seq:nextval@seq_cc_feedback},
	${def:org},
	${fld:customer_code},
	${fld:fbtype},
	null,
	${fld:complainttype},
	(select user_id from hr_staff where name=${fld:complaint_userid} or user_pinyin=${fld:complaint_userid}),
	${fld:complaint_skill},
	${fld:complaint_item},
	${fld:complaint_envir},
	${fld:fbremark},
	1,
	'${def:user}',
	{ts '${def:timestamp}'}
	)