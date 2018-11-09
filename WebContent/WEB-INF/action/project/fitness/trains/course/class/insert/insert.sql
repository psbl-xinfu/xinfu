INSERT INTO et_class(
	tuid,
	class_name,
	courseid,
	resourceid,
	createdby,
	created,
	updatedby,
	updated,
	showorder,
	status
	) VALUES(
	${seq:nextval@seq_et_class},
	${fld:class_name},
	${fld:courseid},
	${fld:resourceid},
	'${def:user}',
	{ts '${def:timestamp}'},
	null,
	null,
	${fld:showorder},
	1
	)