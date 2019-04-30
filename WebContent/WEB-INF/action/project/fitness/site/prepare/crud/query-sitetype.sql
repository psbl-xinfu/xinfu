SELECT
	config.param_value,
	config.param_text
FROM
	cc_config config
WHERE
	config.CATEGORY = 'sitetype'
and 
	config.org_id ='${def:org}'
ORDER BY config.tuid

