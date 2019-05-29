SELECT 
	(
		CASE WHEN EXISTS(
			SELECT 1 FROM hr_staff 
			WHERE userlogin = '${def:user}' AND is_member = 1 
		) THEN '/action/project/fitness/wx/cust/home' 
		WHEN EXISTS(
			SELECT 1 FROM hr_staff_skill sk 
			INNER JOIN hr_skill k ON sk.skill_id = k.skill_id 
			WHERE sk.userlogin = '${def:user}' AND k.org_id = ${def:org} 
			AND (k.skill_name LIKE '%私教经理%') 
		) THEN '/action/project/fitness/wx/pt/home' 
		WHEN EXISTS(
			SELECT 1 FROM hr_staff_skill sk 
			INNER JOIN hr_skill k ON sk.skill_id = k.skill_id 
			WHERE sk.userlogin = '${def:user}'  AND k.org_id = ${def:org} 
			AND (k.skill_name LIKE '%私教%' OR k.skill_name LIKE '%私人教练%' OR k.skill_name LIKE '%教练%') AND k.skill_name != '私教经理' 
		) THEN '/action/project/fitness/wx/pt/home？' 
		ELSE '/action/project/fitness/wx/mc/home' END 
	) AS skilluri
