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
) 
SELECT 
	COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'') || (nextval('seq_cc_ptchange')::varchar)
	,(CASE WHEN ${fld:newcustcode} IS NOT NULL AND ${fld:newcustcode} != '' THEN ${fld:newcustcode} ELSE ${fld:custcode} END)
	,'3'
	,currval('seq_cc_ptrest')::varchar
	,createdby
	,'${def:user}'
	,'${def:date}'
	,1
	,${def:org}
FROM cc_ptrest 
WHERE code = ${fld:ptrestcode} and org_id = ${def:org}
AND 0 = (ptleftcount - ${fld:ptclasscount}) 
