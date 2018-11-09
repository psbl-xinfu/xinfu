INSERT INTO cc_trainplan(
	code,
	customercode,
	ptid,
	ptpreparecode,
	ptlevelcode,
	warmup_mins,
	aerobic_mins,
	run_mileage,
	status,
	createdby,
	created,
	org_id
) VALUES(
	${seq:currval@seq_cc_trainplan},
	${fld:customercode},
	${fld:ptid},
	${fld:ptpreparecode},
	${fld:pdcode},
	${fld:warmup_mins},
	${fld:aerobic_mins},
	${fld:run_mileage},
	1,
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)