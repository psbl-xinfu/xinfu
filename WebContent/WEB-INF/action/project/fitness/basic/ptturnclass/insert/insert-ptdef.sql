INSERT INTO cc_ptdef(
	code
	,ptlevelname
	,ptfee
	,scale
	,status
	,remark
	,reatetype
	,is_delay
	,org_id
	,times
	,spacing
	,createdby
	,created
) 
SELECT 
	${seq:nextval@seq_cc_ptdef},
	pd.ptlevelname,
	pd.ptfee,
	pd.scale,
	pd.status,
	pd.remark,
	pd.reatetype,
	pd.is_delay,
	${fld:org_id},
	pd.times,
	pd.spacing,
	'${def:user}',
	{ts '${def:timestamp}'}
FROM cc_ptdef pd
WHERE pd.code in (select ptlevelcode from cc_ptrest where code = ${fld:ptrestcode} and org_id = ${def:org}) and pd.org_id = ${def:org}
and pd.org_id != ${fld:org_id}::int
and (select count(1) from cc_ptdef cp where cp.org_id = ${fld:org_id} and cp.ptlevelname = pd.ptlevelname)<1

