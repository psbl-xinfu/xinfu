SELECT 
	COALESCE((
		SELECT SUM(normalmoney)/COUNT(1) 
		FROM cc_contract g 
		WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
		AND contracttype = 0 AND type = 2 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
		AND status >= 2
	),0.0) AS avgfee	/** 当前 */
	,COALESCE((
		SELECT SUM(normalmoney)/COUNT(1) 
		FROM cc_contract g 
		WHERE createdate >= (${fld:fdate} - interval '1 year') AND createdate <= (${fld:tdate} - interval '1 year')  
		AND contracttype = 0 AND type = 2 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
		AND status >= 2
	),0.0) AS yearavgfee	/** 同比 */
	,COALESCE((
		SELECT SUM(normalmoney)/COUNT(1) 
		FROM cc_contract g 
		WHERE createdate >= (${fld:fdate} - interval '1 month') AND createdate <= (${fld:tdate} - interval '1 month')  
		AND contracttype = 0 AND type = 2 
		and (case when ${fld:org_id} is null then g.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else g.org_id =${fld:org_id} end)
		AND status >= 2
	),0.0) AS monthavgfee	/** 环比 */ 
FROM dual