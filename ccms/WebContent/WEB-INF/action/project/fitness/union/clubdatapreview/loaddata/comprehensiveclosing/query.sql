SELECT 
	v.visitdate AS createdate, 
	SUM(CASE WHEN v.preparecode IS NULL OR v.preparecode = '' THEN 1 ELSE 0 END) AS num1, 
	SUM(CASE WHEN v.preparecode IS NOT NULL AND v.preparecode != '' THEN 1 ELSE 0 END) AS num2 
FROM cc_guest_visit v 
WHERE v.visitdate >= ${fld:fdate} AND v.visitdate <= ${fld:tdate} 
and (case when ${fld:org_id} is null then v.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else v.org_id =${fld:org_id} end)
AND v.status != 0 
GROUP BY v.visitdate 
ORDER BY v.visitdate



