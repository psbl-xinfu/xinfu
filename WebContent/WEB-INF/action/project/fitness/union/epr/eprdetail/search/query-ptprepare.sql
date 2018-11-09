SELECT 
	SUM(1) AS pt_prepare_num,	-- 私教课预约数
	SUM(CASE a.status WHEN 2 THEN 1 ELSE 0 END) AS pt_prepare_success_num	-- 私教课出现数
FROM cc_prepare a 
WHERE a.created::date = ${fld:date}::date 
and (case when ${fld:org_id} is null then a.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
		UNION 
		SELECT g.org_id FROM hr_org g WHERE EXISTS(
			SELECT 1 FROM hr_staff_org so 
			INNER JOIN hr_staff f ON so.user_id = f.user_id 
			WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else a.org_id =${fld:org_id} end)
