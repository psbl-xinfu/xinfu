SELECT rowno::integer-1 AS rowno, param_text FROM (
	SELECT ROW_NUMBER() OVER() AS rowno, param_text, status FROM (
		SELECT config.param_text, config.status FROM cc_config config WHERE config.category = 'OtherPayWay'
		and config.org_id = (case when 
				not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
				then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
		ORDER BY tuid
	) AS t1 
) AS t2 WHERE status = 1
