SELECT
	f.name AS vc_name,	-- 私教
	p.vc_ptlevelname,	-- 私教类型
	COUNT(1) AS ptcount,	-- 上课节数
	SUM(t.f_ptfee) AS f_ptfactfee,	-- 课时费
	SUM(t.f_scale) AS f_scale	-- 提成金额
FROM e_ptlog g 
INNER JOIN e_ptrest t ON g.vc_ptcode = t.vc_code 
INNER JOIN e_ptdef p ON t.vc_ptlevelcode = p.vc_code 
LEFT JOIN hr_staff f ON g.vc_ptid = f.userlogin 
WHERE g.i_status = 0 
${filter} 
AND (
	t.vc_club = '${def:tenantry}' OR 
	charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE t.vc_club = tenantry_id::varchar)) >= 1 
)
GROUP BY f.name, p.vc_ptlevelname 
ORDER BY f.name, p.vc_ptlevelname




