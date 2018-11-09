insert into cc_guest_group_member
(
	tuid,
	groupid,
	guesttype,
	pkvalue,
	status,
	createdby,
	created,
	org_id
)
values
(
	${seq:nextval@seq_cc_guest_group_member},
	currval('seq_cc_guest_group'),
	${fld:customertype},
	${fld:pkvalue},
	1,
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)
