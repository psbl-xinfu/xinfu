insert into cc_classprepare
(
	code,
	classlistcode,
	issank,
	status,
	customercode,
	createdby,
	created,
	org_id,
	custname,
	phone
)
values
(
	${seq:nextval@seq_cc_classprepare},
	${fld:classlistcode},
	1,
	1,
	 ${fld:customercode},
	'${def:user}',
	'${def:timestamp}',
	${def:org},
	(select name from cc_customer where code= ${fld:customercode} and org_id=${def:org}),
	(select mobile from cc_customer where code= ${fld:customercode} and org_id=${def:org})
)









