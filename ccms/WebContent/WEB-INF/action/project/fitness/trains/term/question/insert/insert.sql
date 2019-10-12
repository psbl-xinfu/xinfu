INSERT INTO et_term_question(
tuid,
termid,
question_name,
question_code,
question_score,
question_type,
showorder,
createdby,
created,
updatedby,
updated
	) VALUES(
	${seq:nextval@seq_et_term_question},
	${fld:termid},
	${fld:question_name},
    ${fld:question_code},
	${fld:question_score},
	${fld:question_type},
	${fld:showorder},
	'${def:user}',
	{ts '${def:timestamp}'},
	null,
	null
	)