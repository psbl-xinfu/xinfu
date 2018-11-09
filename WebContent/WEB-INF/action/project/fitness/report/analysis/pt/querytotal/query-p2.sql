SELECT 
	(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	) AS p2num	/** 当前 */
	,(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 year') AND createdate <= (${fld:tdate} - interval '1 year')  
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	) AS yearp2num	/** 同比 */
	,(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 month') AND createdate <= (${fld:tdate} - interval '1 month')  
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
	) AS monthp2num	/** 环比 */ 
FROM dual

