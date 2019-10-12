INSERT INTO et_course(
	tuid, 
	course_name, 
	course_desc, 
	termid, 
	status, 
	createdby, 
	created
) VALUES(
	${seq:nextval@seq_et_course},
	${fld:course_name},
	${fld:course_desc},
	NULL,
	1,
	'${def:user}',
	{ts '${def:timestamp}'}
)
