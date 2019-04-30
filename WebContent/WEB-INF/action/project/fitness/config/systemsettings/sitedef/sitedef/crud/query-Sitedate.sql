SELECT
	config.tuid as sitedateid,
	config.param_value as sitedate_value
FROM
	cc_config config
WHERE
	config.category = 'Sitedate'
	and config.org_id = '${def:org}'