insert into cc_classprepare
(
	code,
	classlistcode,
	cardcode,
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
	(case when ${fld:issank}='0' then null else ${fld:cardcode} end),
	${fld:issank},
	1,
	(case when ${fld:issank}='0' then null else ${fld:customercode} end),
	'${def:user}',
	'${def:timestamp}',
	${def:org},
	${fld:cust},
	${fld:mobile}
)









