SELECT 
	COUNT(1) AS pi_prepare_success_num	-- P1出现人数
FROM cc_ptrest p 
INNER JOIN cc_ptlog g ON p.code = g.ptrestcode and p.org_id = g.org_id 
WHERE g.created::date = ${fld:date}::date 
AND p.pttype = 5 AND NOT EXISTS (
	SELECT 1 FROM cc_ptlog g WHERE p.code = g.ptrestcode and g.org_id = p.org_id AND g.created::date < ${fld:date}::date 
) 
and (case when ${fld:org_id} is null then p.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
		UNION 
		SELECT g.org_id FROM hr_org g WHERE EXISTS(
			SELECT 1 FROM hr_staff_org so 
			INNER JOIN hr_staff f ON so.user_id = f.user_id 
			WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else p.org_id =${fld:org_id} end)
