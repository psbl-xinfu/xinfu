SELECT 
	 t.intime::date AS createdate,
	 COUNT(1) AS num 
FROM cc_inleft t 
WHERE t.intime::date >= ${fld:fdate} AND t.intime::date <= ${fld:tdate} 
and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
GROUP BY t.intime::date