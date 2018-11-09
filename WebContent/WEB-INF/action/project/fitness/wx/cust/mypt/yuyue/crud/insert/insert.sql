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
	${fld:pdate},
	(${fld:hour} ||':'||${fld:minute})::time,
	4,
	'${def:user}',
	{ts '${def:timestamp}'},
	(${fld:hour} ||':'||${fld:minute})::time,
	(select ((${fld:hour} ||':'||${fld:minute})::time+ (times||' minutes')::interval) from cc_ptdef where code = ptlevelcode and org_id = ${def:org}),
	${def:org}
	from cc_ptrest
	where code = ${fld:ptcode} and org_id=${def:org}
)