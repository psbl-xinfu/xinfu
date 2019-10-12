SELECT
	config.param_value,
	config.param_text
FROM
	cc_config config
WHERE
	config.CATEGORY = 'sitetype'
and 
	config.org_id in (SELECT g.org_id FROM hr_org g WHERE (case when '${def:org}'='' then 1=1 else g.org_id::varchar = '${def:org}' end) 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id))
ORDER BY config.tuid

