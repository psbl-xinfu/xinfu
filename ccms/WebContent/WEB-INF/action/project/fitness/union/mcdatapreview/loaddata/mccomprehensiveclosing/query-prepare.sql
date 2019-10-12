SELECT 
	t.created::date AS createdate, 
	SUM(1) AS num, 
	SUM(CASE WHEN t.status = 3 AND t.contractcode IS NOT NULL AND t.contractcode != '' THEN 1 ELSE 0 END) AS num1 
FROM cc_guest_visit t 
WHERE t.created::date >= ${fld:fdate} AND t.created::date <= ${fld:tdate} 
AND t.preparecode IS NOT NULL AND t.preparecode != '' 
and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
AND t.status != 0 
GROUP BY t.created::date
