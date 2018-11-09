select
	(
		SELECT count(1)
		FROM cc_guest_visit gv 
		WHERE gv.visitdate >= ${fld:fdate} AND gv.visitdate <= ${fld:tdate} 
		AND gv.status =3 and gv.posptid is not null and gv.posptid!='' AND gv.org_id = ${def:org} 
	) as posnum,/** 当前POS教练接待数 */
	(
		SELECT count(1) 
		FROM cc_contract t 
		WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
		AND t.type = 0 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 
	) as cardnum,/** 当前办卡数 */
	(
		SELECT count(1)
		FROM cc_guest_visit gv 
		WHERE gv.visitdate >= (${fld:fdate} - interval '1 year') AND gv.visitdate <= (${fld:tdate} - interval '1 year')   
		AND gv.status =3 and gv.posptid is not null and gv.posptid!='' AND gv.org_id = ${def:org} 
	) as yearposnum,/** 同比POS教练接待数 */
	(
		SELECT count(1) 
		FROM cc_contract t 
		WHERE t.createdate >= (${fld:fdate} - interval '1 year') AND t.createdate <= (${fld:tdate} - interval '1 year')
		AND t.type = 0 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 
	) as yearcardnum,/** 同比办卡数 */
	(
		SELECT count(1)
		FROM cc_guest_visit gv 
		WHERE gv.visitdate >= (${fld:fdate} - interval '1 month') AND gv.visitdate <= (${fld:tdate} - interval '1 month')   
		AND gv.status =3 and gv.posptid is not null and gv.posptid!='' AND gv.org_id = ${def:org} 
	) as monthposnum,/** 环比POS教练接待数 */
	(
		SELECT count(1) 
		FROM cc_contract t 
		WHERE t.createdate >= (${fld:fdate} - interval '1 month') AND t.createdate <= (${fld:tdate} - interval '1 month')
		AND t.type = 0 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 
	) as monthcardnum/** 环比办卡数 */
from dual
