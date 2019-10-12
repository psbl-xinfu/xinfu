SELECT 
	ptlevelname
FROM cc_ptdef 
WHERE status = 1 
AND reatetype != 1 
AND org_id = ${def:org}