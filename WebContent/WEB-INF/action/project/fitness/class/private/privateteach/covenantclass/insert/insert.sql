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
select 
	${seq:nextval@seq_cc_ptprepare},
	p.ptid,
	p.code,
	p.customercode,
	${fld:pdate},
	(${fld:hour} ||':'||${fld:minute})::time,
	1,
	'${def:user}',
	{ts '${def:timestamp}'},
	(${fld:hour} ||':'||${fld:minute})::time,
	(select ((${fld:hour} ||':'||${fld:minute})::time+ (times||' minutes')::interval) from cc_ptdef where code = p.ptlevelcode),
	${def:org} 
from cc_ptrest p 
where p.code = ${fld:ptcode} and p.org_id=${def:org}
