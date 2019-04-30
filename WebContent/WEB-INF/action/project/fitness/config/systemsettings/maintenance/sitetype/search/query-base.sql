SELECT
    config.tuid as cnfg_id,
    config.param_value as vc_topic,
	config.param_text as vc_content
FROM
	cc_config config
WHERE
	config.category = 'sitetype'
and 
	config.org_id = '${def:org}'