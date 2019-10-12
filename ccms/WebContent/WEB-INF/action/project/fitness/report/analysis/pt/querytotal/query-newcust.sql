SELECT 
	COALESCE((
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
		and exists(
			select 1 from cc_contract c where cc_contract.customercode = c.customercode
			AND c.contracttype = 0 AND c.type = 0 and cc_contract.createdate = c.createdate
			AND c.org_id = ${def:org} AND c.status != 0
		)
	),0.0) AS newcust	/** 当前 */
	,COALESCE((
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 year') AND createdate <= (${fld:tdate} - interval '1 year')  
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
		and exists(
			select 1 from cc_contract c where cc_contract.customercode = c.customercode
			AND c.contracttype = 0 AND c.type = 0 and cc_contract.createdate = c.createdate
			AND c.org_id = ${def:org} AND c.status != 0
		)
	),0.0) AS yearnewcust	/** 同比 */
	,COALESCE((
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 month') AND createdate <= (${fld:tdate} - interval '1 month')  
		AND contracttype = 0 AND type = 2 
		AND org_id = ${def:org} AND status >= 2
		and exists(
			select 1 from cc_contract c where cc_contract.customercode = c.customercode
			AND c.contracttype = 0 AND c.type = 0 and cc_contract.createdate = c.createdate
			AND c.org_id = ${def:org} AND c.status != 0
		)
	),0.0) AS monthnewcust	/** 环比 */ 
FROM dual
