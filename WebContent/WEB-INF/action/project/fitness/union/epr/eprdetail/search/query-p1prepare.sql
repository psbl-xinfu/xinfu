SELECT 
	COUNT(1) AS pi_prepare_num	-- P1预约人数
FROM cc_prepare p 
WHERE p.created::date = ${fld:date}::date 

--AND EXISTS (
	--SELECT 1 FROM cc_ptrest t WHERE t.cardcode = p.cardcode AND t.pttype = 5 
	--AND t.org_id = ${def:org} AND NOT EXISTS (
		--SELECT 1 FROM cc_ptlog g WHERE t.vcode = g.ptcode AND g.org_id = ${def:org} and g.created < (${fld:date}||'-01 00:00:00')::timestamp 
	--)
--)
and (case when ${fld:org_id} is null then p.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
		UNION 
		SELECT g.org_id FROM hr_org g WHERE EXISTS(
			SELECT 1 FROM hr_staff_org so 
			INNER JOIN hr_staff f ON so.user_id = f.user_id 
			WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else p.org_id =${fld:org_id} end)
