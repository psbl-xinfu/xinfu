SELECT 
	cdate
	,SUM(p2_cust_num) AS p2_cust_num
	,SUM(p2_num) AS p2_num 
FROM (
	SELECT 
		(
			CASE WHEN t1.cdate IS NOT NULL THEN t1.cdate 
			WHEN t2.cdate IS NOT NULL THEN t2.cdate END
		) AS cdate
		,t1.p2_cust_num
		,t2.p2_num 
	FROM (
		SELECT g.created::date AS cdate, COUNT(1) AS p2_cust_num 
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
		GROUP BY g.created::date
	) AS t1 
	FULL JOIN (
		SELECT g.created::date AS cdate, COUNT(1) AS p2_num
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
		GROUP BY g.created::date
	) AS t2 ON t1.cdate = t2.cdate 
) AS tp 
GROUP BY cdate
