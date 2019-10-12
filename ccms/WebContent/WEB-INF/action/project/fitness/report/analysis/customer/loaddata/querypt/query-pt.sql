SELECT 
	c.createdate, SUM(1) AS num, SUM(
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_contract c1 
			WHERE c1.contracttype = 0 AND c1.type = 2 
			AND c.createdate >= c1.createdate AND c1.code != c.code 
			AND c1.status >= 2 AND c1.org_id = c.org_id 
		) THEN 1 ELSE 0 END
	) AS num1  
FROM cc_contract c 
WHERE c.contracttype = 0 AND c.type = 2 
AND c.status >= 2 AND c.org_id = ${def:org} 
GROUP BY c.createdate 
ORDER BY c.createdate
