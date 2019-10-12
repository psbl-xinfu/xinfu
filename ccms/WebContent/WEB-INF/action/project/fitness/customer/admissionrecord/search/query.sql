SELECT 
	to_char(indate,'yyyy-MM') AS month,
	COUNT(1) AS visit_num 
FROM cc_inleft 
WHERE customercode = ${fld:vc_custcode} and org_id = ${def:org}
AND to_char(indate,'yyyy') = to_char('${def:date}'::timestamp,'yyyy') 
GROUP BY to_char(indate,'yyyy-MM') 
