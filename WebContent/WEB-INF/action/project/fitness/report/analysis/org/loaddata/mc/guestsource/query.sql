SELECT 
	COALESCE((
		SELECT d.param_text FROM cc_config d 
		WHERE d.category = 'GuestType' AND d.param_value = g.type::varchar LIMIT 1
	),'未知') AS descr, 
	count(1) AS num 
FROM cc_guest g 
WHERE g.created::date >= ${fld:fdate} AND g.created::date <= ${fld:tdate} 
AND g.status != 0 AND g.status != 99 AND g.org_id = ${def:org} 
GROUP BY g.type