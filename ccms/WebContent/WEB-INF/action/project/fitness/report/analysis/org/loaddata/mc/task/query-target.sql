SELECT COUNT(1) AS finishnum 
FROM cc_report_task_monthly t 
WHERE t.target_year = ${fld:year} AND t.target_month = ${fld:month} 
AND t.org_id = ${def:org} AND t.isfinish = 1 
AND EXISTS(
	SELECT 1 FROM hr_staff_skill fk  
	INNER JOIN hr_skill k ON fk.skill_id = k.skill_id 
	WHERE fk.user_id = t.user_id AND k.skill_scope = '2' 
)
