SELECT DISTINCT s.user_id, s.userlogin, s.name 
FROM hr_staff s 
INNER JOIN hr_staff_skill sk ON s.user_id = sk.user_id 
INNER JOIN hr_skill k ON sk.skill_id = k.skill_id 
WHERE k.skill_name IN ('会籍顾问','会籍经理','管理员','店长') 
AND (
	s.tenantry_id = ${def:tenantry} OR 
	charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE tenantry_id = s.tenantry_id)) >= 1 
)
