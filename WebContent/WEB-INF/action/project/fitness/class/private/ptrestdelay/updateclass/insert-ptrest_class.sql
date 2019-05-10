insert into cc_ptrest_class
(
	code,
	ptrestcode,
	oldpt,
	newpt,
	remark,
	createdby,
	created,
	org_id
)
values
(
	${seq:nextval@seq_cc_ptrest_class},
	${fld:code},
	${fld:restclass},
	${fld:updateclass},
	${fld:remark},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)