SELECT
	config.param_value as yyparam_value
FROM
	cc_config config
WHERE
	config.category = 'SitedefMinimumConsumptionDate'
	and config.org_id ='${def:org}'