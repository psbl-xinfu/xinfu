SELECT 
	g.preparedate AS createdate,
	COUNT(1) AS num 
FROM cc_guest_prepare g 
WHERE g.createdby = '${def:user}' 
AND ${fld:fdate} <= g.preparedate AND ${fld:tdate} >= g.preparedate 
AND g.org_id = ${def:org} 
AND g.status != 0 
GROUP BY g.preparedate
