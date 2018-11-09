SELECT 
	t.customercode,
	(
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_contract ct 
			WHERE ct.createdate >= t.created::date AND ct.createdate <= t.second_time::date 
			AND ct.contracttype = 0 AND ct.type = 2 AND ct.status >= 2 AND ct.org_id = t.org_id
		) THEN 1 ELSE 0 END
	) AS iscttn
FROM (
	SELECT 
		g.code,
		g.customercode,
		g.created,
		g.org_id,
		(
			SELECT g2.created FROM cc_ptlog g2 
			INNER JOIN cc_ptdef d2 ON d2.code = g2.ptlevelcode AND d2.org_id = g2.org_id 
			WHERE g2.ptrestcode = g.ptrestcode AND g2.customercode = g.customercode 
			AND g2.org_id = g.org_id AND g2.code != g.code AND d2.reatetype = 1 AND g2.status != 0 
			ORDER BY g2.created LIMIT 1
		) AS second_time 
	FROM cc_ptlog g 
	INNER JOIN cc_ptdef d ON d.code = g.ptlevelcode AND d.org_id = g.org_id 
	WHERE g.created::date >= ${fld:fdate} AND g.created::date <= ${fld:tdate} 
	AND d.reatetype = 1 AND g.status != 0 AND g.org_id = ${def:org} 
	AND NOT EXISTS(
		SELECT 1 FROM cc_ptlog g2 
		INNER JOIN cc_ptdef d2 ON d2.code = g2.ptlevelcode AND d2.org_id = g2.org_id 
		WHERE g2.ptrestcode = g.ptrestcode AND g2.customercode = g.customercode 
		AND g2.created > g.created AND g2.org_id = g.org_id AND g2.code != g.code AND d2.reatetype = 1 AND g2.status != 0 
	)
) AS t 

