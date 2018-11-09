SELECT 
	(
		SELECT COUNT(1) FROM cc_guest_visit t WHERE t.visitdate = {d '${def:date}'} 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS todayvisit	/** 当天 */
	,(
		
		SELECT COUNT(1) FROM cc_guest_visit t WHERE t.visitdate = ({d '${def:date}'} - interval '1 month')::date 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS premonthvisit	/** 环比 */
	,(
		SELECT COUNT(1) FROM cc_guest_visit t WHERE to_char(t.visitdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS monthvisit	/** 本月 */
FROM dual