SELECT 
	(
		SELECT COUNT(1) 
		FROM cc_contract g 
		WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
		AND contracttype = 0 AND type = 2 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
		AND status >= 2
	) AS ratefinishnum	/** 当前 */
	,(
		SELECT count(1) 
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
		AND g.status != 0
	) AS ratevisitnum	/** 当前 */
	,(
		SELECT COUNT(1) 
		FROM cc_contract g 
		WHERE createdate >= (${fld:fdate} - interval '1 year') AND createdate <= (${fld:tdate} - interval '1 year')  
		AND contracttype = 0 AND type = 2 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
		AND status >= 2
	) AS yearratefinishnum	/** 同比 */
	,(
		SELECT count(1) 
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
		AND g.status != 0
	) AS yearratevisitnum	/** 同比 */
	,(
		SELECT COUNT(1) 
		FROM cc_contract g 
		WHERE createdate >= (${fld:fdate} - interval '1 month') AND createdate <= (${fld:tdate} - interval '1 month')  
		AND contracttype = 0 AND type = 2 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
		AND status >= 2
	) AS monthratefinishnum	/** 环比 */ 
	,(
		SELECT count(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= (${fld:fdate} - interval '1 month') AND g.created::date <= (${fld:tdate} - interval '1 month') 
		AND p.pttype = 5 
		and g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g 
				WHERE EXISTS(SELECT 1 FROM hr_staff_org so WHERE so.userlogin = '${def:user}' AND so.org_id = g.org_id))
		AND g.status != 0
	) AS monthratevisitnum	/** 环比 */ 
FROM dual