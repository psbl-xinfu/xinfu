SELECT 
	COALESCE((
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
		AND contracttype = 0 AND type = 0 
		AND org_id = ${def:org} AND status != 0
	),0.0) AS expernum	/** 当前 */
	,COALESCE((
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 year') AND createdate <= (${fld:tdate} - interval '1 year')  
		AND contracttype = 0 AND type = 0 
		AND org_id = ${def:org} AND status != 0
	),0.0) AS yearexpernum	/** 同比 */
	,COALESCE((
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 month') AND createdate <= (${fld:tdate} - interval '1 month')  
		AND contracttype = 0 AND type = 0 
		AND org_id = ${def:org} AND status != 0
	),0.0) AS monthexpernum	/** 环比 */ 
FROM dual