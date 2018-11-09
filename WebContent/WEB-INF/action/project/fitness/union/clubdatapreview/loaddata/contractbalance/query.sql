SELECT t.createdate::date AS createdate, t.normalmoney AS fee, 1::integer AS num
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.contracttype != 3 AND t.status >= 2 
and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else  t.org_id =${fld:org_id} end)
AND t.normalmoney > t.factmoney + (
	SELECT SUM(t1.factmoney) 
	FROM cc_contract t1 
	WHERE t1.relatecode = t.code AND t1.org_id = t.org_id 
	AND t1.status >= 2 
)
