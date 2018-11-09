SELECT 
	code
	,ptlevelname
	,(CASE WHEN ptfee IS NULL THEN 0 ELSE ptfee END) AS ptfee
	,scale
	,remark 
FROM cc_ptdef 
WHERE status = 1 
AND reatetype != 1 
AND org_id = ${def:org}