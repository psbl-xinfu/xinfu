SELECT createdate::date AS createdate, t.code, t.customercode, t.org_id 
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.type = 2 AND t.contracttype = 0 AND t.status >= 2 
and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
	