SELECT 
	g.created::date AS createdate,
	COUNT(1) AS num 
FROM cc_comm g 
WHERE g.createdby = '${def:user}' 
AND ${fld:fdate} <= g.created::date AND ${fld:tdate} >= g.created::date 
AND g.org_id = ${def:org} 
AND g.status != 0 
GROUP BY g.created::date
