insert into cc_target_staff
(
	tuid,
	targetgroupid,
	target_type,
	guest_target,
	follow_target,
	prepare_target,
	visit_target,
	ordernum_target,
	orderfee_target,
	call_target,
	call_mc_target,
	call_pt_target,
	test_target,
	unpayclass_target,
	allclass_target,
	site_target,
	user_id,
	userlogin, 
	created,
	createdby,
	org_id
)
values
(
	${seq:nextval@seq_cc_target_staff},
	${fld:tuid},
	0,
	${fld:guest_target},
	${fld:follow_target},
	${fld:prepare_target},
	${fld:visit_target},
	${fld:ordernum_target},
	${fld:orderfee_target},
	${fld:call_target},
	${fld:call_mc_target},
	${fld:call_pt_target},
	${fld:test_target},
	${fld:unpayclass_target},
	${fld:allclass_target},
	${fld:site_target},
	${fld:user_id},
	${fld:userlogin},
    {ts'${def:timestamp}'},
    '${def:user}',
	${def:org}
)

