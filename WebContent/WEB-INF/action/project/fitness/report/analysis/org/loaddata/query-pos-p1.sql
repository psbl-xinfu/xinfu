
		SELECT g.created::${typeformat} AS cdate, COUNT(1) AS p1_cust_num 
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
		GROUP BY g.created::date

		SELECT g.created::date AS cdate, COUNT(1) AS p1_num 
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
		GROUP BY g.created::date

		SELECT g.created::date AS cdate, COUNT(1) AS exper_num 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
		AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
		GROUP BY g.created::date


