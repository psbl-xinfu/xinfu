insert into cc_ptlog 
(
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
	created,
	createdby,
	org_id
)
 
(
	select
		${seq:nextval@seq_cc_ptlog},
		pr.code,
		ptp.customercode,
		ptp.cardcode,
		pd.code,
		pr.ptleftcount,
		pr.ptid,
		pd.ptfee,
		pd.scale,
		1,
		ptp.code,
		ptp.starttime,
		ptp.endtime,
		{ts '${def:timestamp}'},
		'${def:user}',
		${def:org}
	from cc_ptprepare ptp
	left join cc_ptrest pr on ptp.ptrestcode = pr.code and ptp.org_id = pr.org_id
	left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
	where ptp.code = ${fld:code} and ptp.org_id = ${def:org}
)