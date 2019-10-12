SELECT 
	(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	) AS ratefinishnum	/** 当前 */
	,(
		SELECT count(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= ${fld:fdate} AND g.created::date <= ${fld:tdate} 
		AND p.pttype = 5 AND g.org_id = ${def:org} AND g.status != 0
	) AS ratevisitnum	/** 当前 */
	,(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 year') AND createdate <= (${fld:tdate} - interval '1 year')  
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	) AS yearratefinishnum	/** 同比 */
	,(
		SELECT count(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= (${fld:fdate} - interval '1 year') AND g.created::date <= (${fld:tdate} - interval '1 year') 
		AND p.pttype = 5 AND g.org_id = ${def:org} AND g.status != 0
	) AS yearratevisitnum	/** 同比 */
	,(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 month') AND createdate <= (${fld:tdate} - interval '1 month')  
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	) AS monthratefinishnum	/** 环比 */ 
	,(
		SELECT count(1) 
		FROM cc_ptlog g 
		INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
		WHERE g.created::date >= (${fld:fdate} - interval '1 month') AND g.created::date <= (${fld:tdate} - interval '1 month') 
		AND p.pttype = 5 AND g.org_id = ${def:org} AND g.status != 0
	) AS monthratevisitnum	/** 环比 */ 
FROM dual