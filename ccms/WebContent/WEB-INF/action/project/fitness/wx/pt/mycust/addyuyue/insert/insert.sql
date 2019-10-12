INSERT INTO cc_ptprepare(
	code,
	ptid,
	ptrestcode,
	cardcode,
	customercode,
	preparedate,
	preparetime,
	starttime,
	endtime,
	status,
	remark,
	createdby,
	created,
	updatedby,
	updated,
	org_id
	) VALUES(
	${seq:nextval@seq_cc_ptprepare},
	'${def:user}',
	${fld:ptrestcode},
	null,
	${fld:customercode},
	${fld:preparedate},
	${fld:preparetime},
	${fld:preparetime},
	(select (${fld:preparetime}::time+ (pd.times||' minutes')::interval)
	  from cc_ptdef pd
	  LEFT JOIN cc_ptrest pr ON pd.code = pr.ptlevelcode and pd.org_id = pr.org_id 
	  where pr.code=${fld:ptrestcode} and pd.org_id = ${def:org}),
	1,
	null,
	'${def:user}',
	{ts '${def:timestamp}'},
	null,
	null,
	${def:org}
	)