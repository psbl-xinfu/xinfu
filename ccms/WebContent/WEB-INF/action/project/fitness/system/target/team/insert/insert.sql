insert into cc_target_group
(
	tuid,
	target_type,
	target_year,
	target_month,
	pk_value,
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
	createdby,
	created,
	remark,
	org_id
)
values
(
	${seq:nextval@seq_cc_target_group},
	1,
	${fld:target_year},
	${fld:target_month},
	${fld:pk_value},
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
	'${def:user}',
	'${def:timestamp}',
	${fld:remark},
	${def:org}
)

