insert into cc_ptrest_delay
(
	code,
	ptrestcode,
	delayday,
	ptenddate,
	remark,
	createdby,
	created,
	org_id
)
values
(
	${seq:nextval@seq_cc_ptrest_delay},
	${fld:code},
	${fld:datetime},
	(select ptenddate from cc_ptrest where code = ${fld:code} and org_id = ${def:org}),
	${fld:remark},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)