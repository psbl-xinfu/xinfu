SELECT 
	(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status != 0 
	) AS visitnum	/** 当前 */
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= (${fld:fdate} - interval '1 year') AND created::date <= (${fld:tdate} - interval '1 year')  
		AND org_id = ${def:org} AND status != 0 
	) AS yearvisitnum	/** 同比 */
	,(
		SELECT count(1) 
		FROM cc_guest_visit 
		WHERE created::date >= (${fld:fdate} - interval '1 month') AND created::date <= (${fld:tdate} - interval '1 month')  
		AND org_id = ${def:org} AND status != 0 
	) AS monthvisitnum	/** 环比 */ 
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} and gv.visitdate::date >= ${fld:fdate} AND gv.visitdate::date <= ${fld:tdate} 
		and (gv.preparecode is null or gv.preparecode = '') and gv.status!=0
	) AS msnum	/** 当前陌生到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} 
		and gv.visitdate::date >= (${fld:fdate} - interval '1 year') AND gv.visitdate::date <= (${fld:tdate} - interval '1 year')
		and (gv.preparecode is null or gv.preparecode = '') and gv.status!=0
	) AS yearmsnum	/** 同比陌生到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org}
		and gv.visitdate::date >= (${fld:fdate} - interval '1 month') AND gv.visitdate::date <= (${fld:tdate} - interval '1 month')  
		and (gv.preparecode is null or gv.preparecode = '') and gv.status!=0
	) AS monthmsnum	/** 环比陌生到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} and gv.visitdate::date >= ${fld:fdate} AND gv.visitdate::date <= ${fld:tdate} 
		and gv.preparecode is not null and gv.status!=0
	) AS yynum	/** 当前预约到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org}  
		and gv.visitdate::date >= (${fld:fdate} - interval '1 year') AND gv.visitdate::date <= (${fld:tdate} - interval '1 year')
		and gv.preparecode is not null and gv.status!=0
	) AS yearyynum	/** 同比预约到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org}
		and gv.visitdate::date >= (${fld:fdate} - interval '1 month') AND gv.visitdate::date <= (${fld:tdate} - interval '1 month')
		and gv.preparecode is not null and gv.status!=0
	) AS monthyynum	/** 环比预约到访*/
FROM dual