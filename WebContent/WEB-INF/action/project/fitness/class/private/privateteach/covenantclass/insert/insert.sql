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
	(
		case when pttype != 5 then ptid else (
			select c.pt from cc_customer c where c.code = p.customercode and c.org_id = p.org_id 
		) end
	),
	code,
	customercode,
	${fld:pdate},
	(${fld:hour} ||':'||${fld:minute})::time,
	1,
	'${def:user}',
	{ts '${def:timestamp}'},
	(${fld:hour} ||':'||${fld:minute})::time,
	(select ((${fld:hour} ||':'||${fld:minute})::time+ (times||' minutes')::interval) from cc_ptdef where code = ptlevelcode),
	${def:org} 
from cc_ptrest p 
where code = ${fld:ptcode} and org_id=${def:org}
