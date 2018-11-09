INSERT INTO et_group(
	tuid,
	groupname,
	remark,
	status,
	createdby,
	created
) VALUES(
	${seq:nextval@seq_et_group},
	${fld:groupname},
	${fld:remark},
	1,
	'${def:user}',
	{ts '${def:timestamp}'}
)