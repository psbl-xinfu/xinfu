SELECT 
	COUNT(1) AS prepare_visit_num,	-- 预约总数
	SUM(CASE WHEN EXISTS(SELECT 1 FROM cc_guest_visit c WHERE c.preparecode = a.code AND c.status != 0 and c.org_id = a.org_id) 
		THEN 1 ELSE 0 END) AS prepare_success_num,	-- 预约出现数
	SUM(CASE WHEN c.type = 4 THEN 1 ELSE 0 END) AS wi,	-- WI
	SUM(CASE WHEN c.type = 5 THEN 1 ELSE 0 END) AS di,	-- DI
	SUM(CASE WHEN c.type = 0 THEN 1 ELSE 0 END) AS br	-- BR
FROM cc_guest_prepare a 
INNER JOIN cc_guest c ON a.guestcode = c.code and a.org_id = c.org_id 
WHERE a.preparedate::date = ${fld:date}::date AND a.status != 0 
and (case when ${fld:org_id} is null then a.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
		UNION 
		SELECT g.org_id FROM hr_org g WHERE EXISTS(
			SELECT 1 FROM hr_staff_org so 
			INNER JOIN hr_staff f ON so.user_id = f.user_id 
			WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else a.org_id =${fld:org_id} end)
