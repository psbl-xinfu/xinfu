SELECT 
	(
		SELECT COUNT(1) FROM cc_ptlog t 
		WHERE t.created::date = {d '${def:date}'} 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS todaypt	/** 当天 */
	,(
		
		SELECT COUNT(1) FROM cc_ptlog t 
		WHERE t.created::date = ({d '${def:date}'} - interval '1 month')::date 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS premonthpt	/** 环比 */
	,(
		SELECT COUNT(1) FROM cc_ptlog t 
		WHERE to_char(t.created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS monthpt	/** 本月 */
FROM dual