SELECT g.created::date AS createdate, g.code, g.customercode, g.org_id 
FROM cc_ptlog g 
INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
AND p.pttype = 5 
and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)

