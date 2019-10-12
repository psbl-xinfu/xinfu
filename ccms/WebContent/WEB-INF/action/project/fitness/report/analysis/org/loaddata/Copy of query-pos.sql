SELECT 
	SUM(1) AS cust_num
	,SUM(
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_ptlog g 
			INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
			WHERE p.pttype = 5 AND g.org_id = ${def:org} 
			AND g.customercode = t.customercode 
			AND NOT EXISTS(
				SELECT 1 FROM cc_ptlog g2 
				WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
				AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
			)
		) THEN 1 ELSE 0 END
	) AS p1_cust_num
	,SUM(
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_ptlog g 
			INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
			WHERE p.pttype = 5 AND g.org_id = ${def:org} 
			AND g.customercode = t.customercode 
			AND EXISTS(
				SELECT 1 FROM cc_ptlog g2 
				WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
				AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
			)
		) THEN 1 ELSE 0 END
	) AS p2_cust_num 
	,(
		SELECT COUNT(1) AS p1_num
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
		AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
		AND NOT EXISTS(
			SELECT 1 FROM cc_ptlog g2 
			WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
			AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
		)
	) AS p1_num
	,(
		SELECT COUNT(1) AS p1_num
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
		AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_ptlog g2 
			WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
			AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
		)
	) AS p2_num
	,(
		SELECT COUNT(1) AS p1_num
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
		AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
	) AS exper_num 
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.type = 2 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 




SELECT 
	SUM(1) AS cust_num
	,SUM(
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_ptlog g 
			INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
			WHERE p.pttype = 5 AND g.org_id = ${def:org} 
			AND g.customercode = t.customercode 
			AND NOT EXISTS(
				SELECT 1 FROM cc_ptlog g2 
				WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
				AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
			)
		) THEN 1 ELSE 0 END
	) AS p1_cust_num
	,SUM(
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_ptlog g 
			INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
			WHERE p.pttype = 5 AND g.org_id = ${def:org} 
			AND g.customercode = t.customercode 
			AND EXISTS(
				SELECT 1 FROM cc_ptlog g2 
				WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
				AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
			)
		) THEN 1 ELSE 0 END
	) AS p2_cust_num 
	,(
		SELECT COUNT(1) AS p1_num
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
		AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
		AND NOT EXISTS(
			SELECT 1 FROM cc_ptlog g2 
			WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
			AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
		)
	) AS p1_num
	,(
		SELECT COUNT(1) AS p1_num
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
		AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_ptlog g2 
			WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
			AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
		)
	) AS p2_num
	,(
		SELECT COUNT(1) AS p1_num
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
		AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
	) AS exper_num 
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.type = 2 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 

