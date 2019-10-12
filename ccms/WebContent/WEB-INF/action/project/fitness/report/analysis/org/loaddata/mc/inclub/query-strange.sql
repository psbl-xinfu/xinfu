SELECT 
	t.created::date AS createdate, 
	SUM(1) AS num, 
	SUM(CASE WHEN t.status = 3 AND t.contractcode IS NOT NULL AND t.contractcode != '' THEN 1 ELSE 0 END) AS num1 
FROM cc_guest_visit t 
WHERE t.created::date >= ${fld:fdate} AND t.created::date <= ${fld:tdate} 
AND (t.preparecode IS NULL OR t.preparecode = '') 
AND t.org_id = ${def:org} AND t.status != 0 
GROUP BY t.created::date
