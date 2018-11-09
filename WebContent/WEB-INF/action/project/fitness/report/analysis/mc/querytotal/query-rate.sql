SELECT 
	(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
		AND contracttype = 0 AND type IN (0,5) 
		AND org_id = ${def:org} AND status >= 2
	) AS ratefinishnum	/** 当前 */
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status != 0
	) AS ratevisitnum	/** 当前 */
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status != 0 and preparecode is not null
	) AS yyratevisitnum	/** 当前  预约成交 */
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE visitdate::date >= ${fld:fdate} AND visitdate::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status = 3 and (preparecode is null or preparecode = '')
	) AS msratevisitnum	/** 当前 陌生成交 */
	,(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 year') AND createdate <= (${fld:tdate} - interval '1 year')  
		AND contracttype = 0 AND type IN (0,5) 
		AND org_id = ${def:org} AND status >= 2
	) AS yearratefinishnum	/** 同比 */
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= (${fld:fdate} - interval '1 year') AND created::date  <= (${fld:tdate} - interval '1 year')  
		AND org_id = ${def:org} AND status != 0
	) AS yearratevisitnum	/** 同比 */
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= (${fld:fdate} - interval '1 year') AND created::date  <= (${fld:tdate} - interval '1 year')  
		AND org_id = ${def:org} AND status != 0 and preparecode is not null
	) AS yearyyratevisitnum	/** 同比  预约成交 */
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE visitdate::date >= (${fld:fdate} - interval '1 year') AND visitdate::date  <= (${fld:tdate} - interval '1 year')  
		AND org_id = ${def:org} AND status = 3 and (preparecode is null or preparecode = '')
	) AS yearmsratevisitnum	/** 同比  陌生成交 */
	,(
		SELECT COUNT(1) 
		FROM cc_contract  
		WHERE createdate >= (${fld:fdate} - interval '1 month') AND createdate <= (${fld:tdate} - interval '1 month')  
		AND contracttype = 0 AND type IN (0,5) 
		AND org_id = ${def:org} AND status >= 2
	) AS monthratefinishnum	/** 环比 */ 
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= (${fld:fdate} - interval '1 month') AND created::date  <= (${fld:tdate} - interval '1 month')  
		AND org_id = ${def:org} AND status != 0
	) AS monthratevisitnum	/** 环比 */ 
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= (${fld:fdate} - interval '1 month') AND created::date  <= (${fld:tdate} - interval '1 month')  
		AND org_id = ${def:org} AND status != 0 and preparecode is not null
	) AS monthyyratevisitnum	/** 环比  预约成交 */ 
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE visitdate::date >= (${fld:fdate} - interval '1 month') AND visitdate::date  <= (${fld:tdate} - interval '1 month')  
		AND org_id = ${def:org} AND status = 3 and (preparecode is null or preparecode = '')
	) AS monthmsratevisitnum	/** 环比  陌生成交 */ 
FROM dual