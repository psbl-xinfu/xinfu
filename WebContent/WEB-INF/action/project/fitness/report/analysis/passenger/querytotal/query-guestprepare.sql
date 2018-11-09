SELECT 
	(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} and gv.visitdate::date = {d '${def:date}'}
		and (gv.preparecode is null or gv.preparecode = '') and gv.status!=0
	) AS msnum	/** 当天陌生到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} and gv.visitdate::date = ({d '${def:date}'} - interval '1 month')::date 
		and (gv.preparecode is null or gv.preparecode = '') and gv.status!=0
	) AS premonthmsnum	/** 环比陌生到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} and to_char(gv.visitdate::date,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM')
		and (gv.preparecode is null or gv.preparecode = '') and gv.status!=0
	) AS monthmsnum	/** 本月陌生到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} and gv.visitdate::date = {d '${def:date}'}
		and gv.preparecode is not null and gv.status!=0
	) AS yynum	/** 当天预约到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} and gv.visitdate::date = ({d '${def:date}'} - interval '1 month')::date 
		and gv.preparecode is not null and gv.status!=0
	) AS premonthyynum	/** 环比预约到访 */
	,(
		select count(1) from cc_guest_visit gv
		where gv.org_id = ${def:org} and to_char(gv.visitdate::date,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM')
		and gv.preparecode is not null and gv.status!=0
	) AS monthyynum	/** 本月 预约到访*/
FROM dual


