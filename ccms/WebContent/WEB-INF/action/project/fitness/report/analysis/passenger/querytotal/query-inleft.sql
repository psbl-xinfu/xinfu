SELECT 
	(
		SELECT COUNT(1) FROM cc_inleft t 
		WHERE t.intime::date = {d '${def:date}'} AND t.org_id = ${def:org}
	) AS todayinleft	/** 当天 */
	,(
		
		SELECT COUNT(1) FROM cc_inleft t 
		WHERE t.intime::date = ({d '${def:date}'} - interval '1 month')::date AND t.org_id = ${def:org}
	) AS premonthinleft	/** 环比 */
	,(
		SELECT COUNT(1) FROM cc_inleft t 
		WHERE to_char(t.intime,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') AND t.org_id = ${def:org}
	) AS monthinleft	/** 本月 */
FROM dual