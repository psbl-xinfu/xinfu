INSERT INTO et_term(
	tuid,
	term_name,
	total_score,
	standard_score,
	createdby,
	created,
	updatedby,
	updated,
	status
	) VALUES(
	${seq:nextval@seq_et_term},
	${fld:term_name},
	${fld:total_score},
	${fld:standard_score},
	'${def:user}',
	{ts '${def:timestamp}'},
	null,
	null,
	1
	)