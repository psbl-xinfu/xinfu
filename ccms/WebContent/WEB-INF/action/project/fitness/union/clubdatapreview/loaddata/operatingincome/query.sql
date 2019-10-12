SELECT 
	f.created::date AS createdate,
	SUM(CASE WHEN f.type = 1 AND f.item IN (10,12,13) THEN f.money ELSE 0.00 END) AS num1,
	SUM(CASE WHEN f.type = 2 AND f.item = 20 THEN f.money ELSE 0.00 END) AS num2,
	SUM(CASE WHEN f.item IS NULL OR (f.item != 10 AND f.item != 12 AND f.item != 13 AND f.item != 20 AND f.item != 33 AND f.item != 34 AND f.item != 35 AND f.item != 36) THEN f.money ELSE 0.00 END) AS num3,
	SUM(CASE WHEN (f.item = 33 OR f.item = 34 OR f.item = 35 OR f.item = 36) THEN f.money ELSE 0.00 END) AS num4 
FROM cc_finance f 
WHERE f.created::date >= ${fld:fdate} AND f.created::date <= ${fld:tdate} 
and (case when ${fld:org_id} is null then f.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else  f.org_id =${fld:org_id} end)
GROUP BY f.created::date