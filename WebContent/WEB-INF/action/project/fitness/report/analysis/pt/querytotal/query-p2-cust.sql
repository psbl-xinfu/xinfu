SELECT 
	(
		SELECT COUNT(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= ${fld:fdate} AND g.created::date <= ${fld:tdate} 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_ptlog g2 
			WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
			AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
		) 
	) AS p2custnum	/** 当前 */
	,(
		SELECT COUNT(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= (${fld:fdate} - interval '1 year') AND g.created::date <= (${fld:tdate} - interval '1 year') 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_ptlog g2 
			WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
			AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
		) 
	) AS yearp2custnum	/** 同比 */
	,(
		SELECT COUNT(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= (${fld:fdate} - interval '1 month') AND g.created::date <= (${fld:tdate} - interval '1 month') 
		AND p.pttype = 5 AND g.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_ptlog g2 
			WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
			AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
		) 
	) AS monthp2custnum	/** 环比 */ 
FROM dual
