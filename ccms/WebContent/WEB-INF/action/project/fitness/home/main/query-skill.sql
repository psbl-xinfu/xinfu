SELECT 
	(
		CASE WHEN EXISTS(
			SELECT 1 FROM hr_staff_skill sk 
			INNER JOIN hr_skill k ON sk.skill_id = k.skill_id 
			WHERE sk.userlogin = '${def:user}' 
			AND (k.skill_name LIKE '%店长%' OR k.skill_name = '区域总经理' OR k.skill_name LIKE '%管理员') 
		) THEN '/action/project/fitness/home/main/leader' 
		WHEN EXISTS(
			SELECT 1 FROM hr_staff_skill sk 
			INNER JOIN hr_skill k ON sk.skill_id = k.skill_id 
			WHERE sk.userlogin = '${def:user}' 
			AND k.skill_name LIKE '%会籍经理%' 
		) THEN '/action/project/fitness/home/main/mcleader' 
		WHEN EXISTS(
			SELECT 1 FROM hr_staff_skill sk 
			INNER JOIN hr_skill k ON sk.skill_id = k.skill_id 
			WHERE sk.userlogin = '${def:user}' 
			AND (k.skill_name LIKE '%私教经理%') 
		) THEN '/action/project/fitness/home/main/ptleader' 
		WHEN EXISTS(
			SELECT 1 FROM hr_staff_skill sk 
			INNER JOIN hr_skill k ON sk.skill_id = k.skill_id 
			WHERE sk.userlogin = '${def:user}' 
			AND (k.skill_name LIKE '%前台%' OR k.skill_name LIKE '%客服%') 
		) THEN '/action/project/fitness/home/main/reception' 
		WHEN EXISTS(
			SELECT 1 FROM hr_staff_skill sk 
			INNER JOIN hr_skill k ON sk.skill_id = k.skill_id 
			WHERE sk.userlogin = '${def:user}' 
			AND (k.skill_name LIKE '%私教%' OR k.skill_name LIKE '%私人教练%' OR k.skill_name LIKE '%教练%') AND k.skill_name != '私教经理' 
		) THEN '/action/project/fitness/home/main/pt' 
		ELSE '/action/project/fitness/home/main/mc' END 
	) AS skilluri
