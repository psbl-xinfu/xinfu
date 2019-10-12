INSERT INTO cc_hkb_faq(
	tuid,
	title,
	content,
	status,
	createdby,
	created,
	org_id
) 
values(
	${seq:nextval@seq_cc_hkb_faq},
	${fld:title},
	${fld:content},
	${fld:status},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)