INSERT INTO et_course_group(
	tuid, 
	groupid, 
	courseid,
	status,
	createdby,
	created
) VALUES(
	${seq:nextval@seq_et_course_group},
	${fld:grouptuid},
	${seq:currval@seq_et_course},
	1,
	'${def:user}',
	{ts '${def:timestamp}'}
)
