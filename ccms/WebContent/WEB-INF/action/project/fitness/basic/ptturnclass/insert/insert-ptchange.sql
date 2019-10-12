INSERT INTO cc_ptchange(
	code
	,customercode
	,type
	,ptrestcode
	,ptid
	,createdby
	,created
	,status
	,org_id
) VALUES(
	COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${fld:org_id}),'') ||(nextval('seq_cc_ptchange')::varchar)
	,(CASE WHEN ${fld:newcustcode} IS NOT NULL AND ${fld:newcustcode} != '' THEN ${fld:newcustcode} ELSE ${fld:custcode} END)
	,'5'
	,${seq:currval@seq_cc_ptrest}
	,(CASE WHEN ${fld:turnclasspt} IS NOT NULL AND ${fld:turnclasspt} != '' THEN ${fld:turnclasspt} 
		ELSE (SELECT createdby FROM cc_ptrest WHERE code = ${fld:ptrestcode} and org_id = ${fld:org_id}) END)
	,'${def:user}'
	,'${def:date}'
	,1
	,${def:org}
)