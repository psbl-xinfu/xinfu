INSERT INTO cc_ptrest(
	code
	,customercode
	,contractcode
	,ptid
	,org_id
	,ptlevelcode
	,pttotalcount
	,ptleftcount
	,ptnormalmoney
	,ptmoney
	,ptfactfee
	,ptfee
	,scale
	,createdby
	,created
	,pttype
	,ptenddate  --zzn
) 
SELECT 
	${seq:nextval@seq_cc_ptrest}
	,(CASE WHEN ${fld:newcustcode} IS NOT NULL AND ${fld:newcustcode} != '' THEN ${fld:newcustcode} ELSE ${fld:custcode} END)
	,NULL
	,(CASE WHEN ${fld:turnclasspt} IS NOT NULL AND ${fld:turnclasspt} != '' THEN ${fld:turnclasspt} ELSE ptid END)
	,${fld:org_id}
	,(case when org_id = ${fld:org_id} then ptlevelcode::int else 
	(case when (select count(1) from cc_ptdef cp where cp.org_id = ${fld:org_id} and cp.ptlevelname = 
		(select ptlevelname from cc_ptdef where code = cc_ptrest.ptlevelcode and org_id = ${def:org}))<1
			then ${seq:currval@seq_cc_ptdef}::int else (select code::int from cc_ptdef cp 
			where cp.org_id = ${fld:org_id} and cp.ptlevelname = 
		(select ptlevelname from cc_ptdef where code = cc_ptrest.ptlevelcode and org_id = ${def:org}))
	 end) end)
	,${fld:ptclasscount}
	,${fld:ptclasscount}
	,ptfee*${fld:ptclasscount}
	,ptfactfee*${fld:ptclasscount}
	,ptfactfee
	,ptfee
	,scale
	,(CASE WHEN ${fld:turnclasspt} IS NOT NULL AND ${fld:turnclasspt} != '' THEN ${fld:turnclasspt} ELSE createdby END)
	,{ts '${def:timestamp}'}
	,4
	,ptenddate -- zzn
FROM cc_ptrest 
WHERE code = ${fld:ptrestcode} and org_id = ${def:org}