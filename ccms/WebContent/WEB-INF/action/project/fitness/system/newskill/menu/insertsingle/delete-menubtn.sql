DELETE FROM hr_skill_menu_btn a WHERE skill_id = ${fld:skill_id} AND EXISTS(
	SELECT 1 FROM hr_menu m1 
	LEFT JOIN hr_menu m2 ON m2.pid = m1.tuid 
	LEFT JOIN hr_menu m3 ON m3.pid = m2.tuid 
	WHERE m1.tuid = ${fld:single_menu_id} 
	AND EXISTS(
		SELECT 1 FROM hr_menu_btn b WHERE b.tuid = a.menu_btn_id 
		AND (b.menu_id = m1.tuid OR b.menu_id = m2.tuid OR b.menu_id = m3.tuid)
	)
)
