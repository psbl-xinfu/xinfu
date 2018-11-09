INSERT INTO cc_ptlog(
	code,
	ptrestcode,
	customercode,
	cardcode,
	ptlevelcode,
	leftcount,
	ptid,
	ptfee,
	scale,
	status,
	preparecode,
	starttime,
	endtime,
	createdby,
	created,
	remark,
	org_id 
) 
VALUES(
	${seq:nextval@seq_cc_ptlog},
	${fld:ptrestcode},
	${fld:customercode},
	${fld:cardcode},
	${fld:ptlevelcode},
	${fld:ptleftcount},
	${fld:ptid},
	${fld:ptfactfee},
	${fld:scale},
	1,
	${fld:ptpreparecode},
	${fld:starttime},
	${fld:endtime},
	'sys',
	{ts '${def:timestamp}'},
	'预约过期爽约自动扣课',
	${fld:org_id} 
)