SELECT 
	(
		SELECT config.param_value FROM cc_config config 
		WHERE config.category = 'IsCardCodeLimit' AND config.org_id = (
			CASE WHEN NOT EXISTS(SELECT 1 FROM cc_config c WHERE c.org_id = ${def:org} AND c.category = config.category) 
			THEN (SELECT org_id FROM hr_org WHERE pid IS NULL OR pid = 0) ELSE ${def:org} END
		) 
	) AS iscardcodelimit	/** 是否限制卡号位数 : 0不限制  1限制 */
	,(
		SELECT config.param_value FROM cc_config config 
		WHERE config.category = 'WhichSevenType' AND config.org_id = (
			CASE WHEN NOT EXISTS(SELECT 1 FROM cc_config c WHERE c.org_id = ${def:org} AND c.category = config.category) 
			THEN (SELECT org_id FROM hr_org WHERE pid IS NULL OR pid = 0) ELSE ${def:org} END
		) 
	) AS cardcodelimitlen	/** 卡号处理方式:0两位头字母+右六位  1两位头字母+右五位  不足位数补0*/
