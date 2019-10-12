insert into cc_guest_group
(
	tuid,
	groupname,
	leader,
	createdby,
	created,
	org_id
)
values
(
	${seq:nextval@seq_cc_guest_group},
	${fld:groupname},
	'${def:user}',
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)
