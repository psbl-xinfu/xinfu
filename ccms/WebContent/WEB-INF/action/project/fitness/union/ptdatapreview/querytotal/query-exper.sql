SELECT 
	(
		SELECT COUNT(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= ${fld:fdate} AND g.created::date <= ${fld:tdate} 
		AND p.pttype = 5 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
	) AS expernum	/** 当前 */
	,(
		SELECT COUNT(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= (${fld:fdate} - interval '1 year') AND g.created::date <= (${fld:tdate} - interval '1 year')  
		AND p.pttype = 5 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
	) AS yearexpernum	/** 同比 */
	,(
		SELECT COUNT(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= (${fld:fdate} - interval '1 month') AND g.created::date <= (${fld:tdate} - interval '1 month')  
		AND p.pttype = 5 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
	) AS monthexpernum	/** 环比 */ 
FROM dual