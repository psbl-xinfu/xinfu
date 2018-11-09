SELECT 
	a.classdate AS c_idate,	-- 日期
	SUM(a.personcount) AS class_num	-- 团操上课人数
FROM cc_classlist a 
WHERE to_char(a.classdate, 'yyyy-MM') = ${fld:month} AND a.status != 0
and (case when ${fld:org_id} is null then a.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else a.org_id =${fld:org_id} end)
GROUP BY a.classdate