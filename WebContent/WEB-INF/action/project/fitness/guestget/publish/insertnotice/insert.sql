INSERT INTO cc_hkb_notice(
	tuid,
	title,
	content,
	level,
	status,
	createdby,
	created,
	org_id
) 
values(
	${seq:nextval@seq_cc_hkb_notice},
	${fld:title},
	${fld:content},
	${fld:level},
	${fld:status},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)