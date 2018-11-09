INSERT INTO cc_ptprepare(
	code,
	ptid,
	ptrestcode,
	customercode,
	preparedate,
	preparetime,
	status,
	createdby,
	created,
	starttime,
	endtime,
	org_id
) 
(
	select 
	${seq:nextval@seq_cc_ptprepare},
	ptid,
	code,
	customercode,
	${fld:preparedate},
	${fld:preparetime}::time,
	1,
	'${def:user}',
	{ts '${def:timestamp}'},
	${fld:preparetime}::time,
	(select (${fld:preparetime}::time+ (times||' minutes')::interval) from cc_ptdef where code = ptlevelcode and org_id = ${def:org}),
	${def:org}
	from cc_ptrest
	where code = ${fld:ptrestcode} and org_id=${def:org}
)