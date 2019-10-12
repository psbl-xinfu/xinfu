SELECT 
	(
		SELECT COUNT(1) FROM cc_ptlog g 
		INNER JOIN cc_ptdef p ON p.code = g.ptlevelcode AND g.org_id = p.org_id 
		WHERE to_char(g.created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
		AND g.ptid = '${def:user}' AND g.org_id = ${def:org} 
		AND p.reatetype != 1 AND g.status != 0
	) AS monthpt
	,(
		SELECT COUNT(1) FROM cc_ptlog g 
		INNER JOIN cc_ptdef p ON p.code = g.ptlevelcode AND g.org_id = p.org_id 
		WHERE g.created::date = {d '${def:date}'} 
		AND g.ptid = '${def:user}' AND g.org_id = ${def:org} 
		AND p.reatetype != 1 AND g.status != 0
	) AS todaypt
	,(
		SELECT COUNT(1) FROM cc_ptlog g 
		INNER JOIN cc_ptdef p ON p.code = g.ptlevelcode AND g.org_id = p.org_id 
		WHERE to_char(g.created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
		AND g.ptid = '${def:user}' AND g.org_id = ${def:org} 
		AND p.reatetype = 1 AND g.status != 0
	) AS monthpttest
	,(
		SELECT COUNT(1) FROM cc_comm g 
		WHERE to_char(g.created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
		AND g.operatortype = 1 AND g.createdby = '${def:user}' AND g.org_id = ${def:org} 
		AND g.status != 0 
	) AS guestnum
FROM dual