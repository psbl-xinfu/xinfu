SELECT 
	(
		SELECT SUM(COALESCE(t.personcount,0)) FROM cc_classlist t 
		WHERE t.classdate = {d '${def:date}'} 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS todayclass	/** 当天 */
	,(
		
		SELECT SUM(COALESCE(t.personcount,0)) FROM cc_classlist t 
		WHERE t.classdate = ({d '${def:date}'} - interval '1 month')::date 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS premonthclass	/** 环比 */
	,(
		SELECT SUM(COALESCE(t.personcount,0)) FROM cc_classlist t 
		WHERE to_char(t.classdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
		AND t.status != 0 AND t.org_id = ${def:org}
	) AS monthclass	/** 本月 */
FROM dual