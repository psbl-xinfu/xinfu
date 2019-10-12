insert into cc_guest_group
(
	tuid,
	groupname,
	createdby,
	created,
	org_id
)
values
(
	currval('seq_cc_guest_group'),
	${fld:groupname},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)
