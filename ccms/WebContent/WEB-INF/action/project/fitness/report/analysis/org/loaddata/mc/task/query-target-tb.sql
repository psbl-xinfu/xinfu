WITH datamonth AS (
	SELECT 
		to_char(ts, 'yyyy')::integer AS year,
		to_char(ts, 'MM')::integer AS month
	FROM (
		SELECT concat(${fld:year},'-',${fld:month},'-01')::date - interval '1 month' AS ts
	) AS t 
)
SELECT COUNT(1) AS finishnumtb 
FROM cc_report_task_monthly t 
WHERE 'T' = ${fld:compareflag} 
AND t.target_year = (SELECT year FROM datamonth) AND t.target_month = (SELECT month FROM datamonth) 
AND t.org_id = ${def:org} AND t.isfinish = 1 
AND EXISTS(
	SELECT 1 FROM hr_staff_skill fk  
	INNER JOIN hr_skill k ON fk.skill_id = k.skill_id 
	WHERE fk.user_id = t.user_id AND k.skill_scope = '2' 
)

