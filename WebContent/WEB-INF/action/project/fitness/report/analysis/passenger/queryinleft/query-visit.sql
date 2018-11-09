SELECT 
	 t.visitdate AS createdate, COUNT(1) AS num 
FROM cc_guest_visit t 
WHERE t.visitdate >= ${fld:fdate} AND t.visitdate <= ${fld:tdate} 
AND t.org_id = ${def:org} AND t.status != 0 
GROUP BY t.visitdate

