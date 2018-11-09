SELECT 
	g.visitdate AS createdate,
	SUM(1) AS visitnum,
	SUM(CASE WHEN g.status = 3 THEN 1 ELSE 0 END) AS sucnum 
FROM cc_guest_visit g 
WHERE g.mc = '${def:user}' 
AND ${fld:fdate} <= g.visitdate AND ${fld:tdate} >= g.visitdate 
AND g.org_id = ${def:org} 
AND g.status != 0 
GROUP BY g.visitdate
