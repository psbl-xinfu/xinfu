SELECT
	config.tuid as cnfg_id,
	config.param_value as vc_topic,
	config.param_text as vc_content,
	(CASE config.status WHEN 1 THEN '已启用' WHEN 0 THEN '已禁用' ELSE '' END) AS vc_status 
FROM
	cc_config config
WHERE
	config.CATEGORY = 'OtherPayWay'
and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
ORDER BY config.tuid

