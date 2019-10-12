SELECT 
	SUM(COALESCE(totalnum,0)) AS saletotalnum
	,SUM(COALESCE(totalfee,0)) AS saletotalfee 
FROM (
	SELECT 
		COUNT(1) AS totalnum
		,SUM(CASE WHEN c.salemember1 IS NOT NULL AND c.salemember1 != '' THEN c.normalmoney/2 ELSE c.normalmoney END) AS totalfee 
	FROM cc_contract c 
	WHERE to_char(c.createdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
	AND c.salemember = '${def:user}' 
	AND c.contracttype = 0 AND c.type = 2 AND c.status >= 2 
	AND c.org_id = ${def:org} 
	
	UNION ALL
	
	SELECT 
		COUNT(1) AS totalnum
		,SUM(c.normalmoney/2) AS totalfee 
	FROM cc_contract c 
	WHERE to_char(c.createdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
	AND c.salemember1 = '${def:user}' 
	AND c.contracttype = 0 AND c.type = 2 AND c.status >= 2 
	AND c.org_id = ${def:org} 
) AS t 
