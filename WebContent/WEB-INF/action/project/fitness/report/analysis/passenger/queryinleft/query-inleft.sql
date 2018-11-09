SELECT 
	 t.intime::date AS createdate, COUNT(1) AS num 
FROM cc_inleft t 
WHERE t.intime::date >= ${fld:fdate} AND t.intime::date <= ${fld:tdate} 
AND t.org_id = ${def:org} 
GROUP BY t.intime::date
