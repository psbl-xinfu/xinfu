insert into cc_storerecord (
	customercode,
	ptmodified,
	mcmodified,
	createdby,
	created,
	originalid
)
VALUES (
	${fld:customercode},
	${fld:ptjsons},
	${fld:mcjsons},
	${fld:createdby},
	{ts '${def:timestamp}'},
	${fld:orgjsons} 
)