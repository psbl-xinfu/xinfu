SELECT 
	SUM(COALESCE(totalnum,0)) AS saletotalnum
	,SUM(COALESCE(totalfee,0)) AS saletotalfee 
FROM (
	SELECT 
		COUNT(1) AS totalnum
		,SUM(CASE WHEN c.salemember1 IS NOT NULL AND c.salemember1 != '' THEN c.normalmoney/2 ELSE c.normalmoney END) AS totalfee 
	FROM cc_contract c 
	WHERE to_char(c.createdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
	AND c.salemember in 
		(select userlogin from hr_staff_skill hss 
			left join hr_skill hs on hss.skill_id = hs.skill_id
			where skill_scope = '1' and hs.org_id = ${def:org}
		) 
	AND c.contracttype = 0 AND c.type = 2 AND c.status >= 2 
	AND c.org_id = ${def:org} 
	
	UNION ALL
	
	SELECT 
		COUNT(1) AS totalnum
		,SUM(c.normalmoney/2) AS totalfee 
	FROM cc_contract c 
	WHERE to_char(c.createdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
	AND c.salemember1 in 
		(select userlogin from hr_staff_skill hss 
			left join hr_skill hs on hss.skill_id = hs.skill_id
			where skill_scope = '1' and hs.org_id = ${def:org}
		) 
	AND c.contracttype = 0 AND c.type = 2 AND c.status >= 2 
	AND c.org_id = ${def:org} 
) AS t 
