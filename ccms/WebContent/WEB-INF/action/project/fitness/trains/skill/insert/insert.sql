INSERT INTO et_course_skill(
	tuid,
	skill_id,
	courseid,
	begin_date,
	end_date,
	showorder,
	status,
	createdby,
	created,
	updatedby,
	updated,
	groupid
	) VALUES(
	${seq:nextval@seq_et_course_skill},
	${fld:skill_id},
	${fld:course_id},
	${fld:begin_date},
	${fld:end_date},
	${fld:showorder},
	1,
	'${def:user}',
	{ts '${def:timestamp}'},
	null,
	null,
	(select  groupid from et_course_group where courseid=${fld:course_id})
	)