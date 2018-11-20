SELECT 
	f.userlogin
	,f.name 
FROM hr_staff f 
WHERE f.org_id = ${def:org} and f.status = 1 AND EXISTS(
	SELECT 1 FROM hr_staff_skill fk 
	INNER JOIN hr_skill k ON k.skill_id = fk.skill_id 
	WHERE f.user_id = fk.user_id AND k.skill_scope IN ('1','2','4') 
)