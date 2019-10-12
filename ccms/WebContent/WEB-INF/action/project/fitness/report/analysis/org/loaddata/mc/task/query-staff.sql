SELECT COUNT(1) AS staffnum 
FROM hr_staff f 
WHERE EXISTS(
	SELECT 1 FROM hr_staff_skill fk  
	INNER JOIN hr_skill k ON fk.skill_id = k.skill_id 
	WHERE fk.user_id = f.user_id AND k.skill_scope = '2' 
) AND f.status = 1 
