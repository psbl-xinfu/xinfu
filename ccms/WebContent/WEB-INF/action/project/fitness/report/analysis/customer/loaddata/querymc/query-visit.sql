SELECT 
	COUNT(1) AS visitnum
FROM cc_guest_visit g 
WHERE g.visitdate >= ${fld:fdate} AND g.visitdate <= ${fld:tdate} 
AND g.status != 0 AND g.org_id = ${def:org} 
