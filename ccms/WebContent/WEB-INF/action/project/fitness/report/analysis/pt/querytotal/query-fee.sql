SELECT 
	COALESCE((
		SELECT SUM(normalmoney)/COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	),0.0) AS avgfee	/** 当前 */
	,COALESCE((
		SELECT SUM(normalmoney)/COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 year') AND createdate <= (${fld:tdate} - interval '1 year')  
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	),0.0) AS yearavgfee	/** 同比 */
	,COALESCE((
		SELECT SUM(normalmoney)/COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 month') AND createdate <= (${fld:tdate} - interval '1 month')  
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	),0.0) AS monthavgfee	/** 环比 */ 
FROM dual