SELECT 
	t.createdate, SUM(t.normalmoney) AS fee, COUNT(1) AS num 
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.contracttype = 0 AND (t.type = 0 OR t.type = 5) 
AND t.status >= 2 AND t.org_id = ${def:org} 
GROUP BY t.createdate
