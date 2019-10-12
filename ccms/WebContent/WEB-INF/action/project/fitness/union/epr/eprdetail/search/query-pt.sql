WITH cfgdata AS (
	SELECT COALESCE((
		SELECT (CASE WHEN param_text IS NULL OR param_text = '' THEN '3' ELSE param_text END) 
		FROM cc_config WHERE category = 'POSDay' LIMIT 1
	),'3')::integer AS posday
) 
SELECT 
	SUM(t.factmoney) AS pt_money	-- 私教业绩
	,SUM(CASE WHEN EXISTS(
		SELECT 1 FROM cc_customer ct 
		WHERE ct.code = t.customercode AND ct.org_id = t.org_id 
		AND (t.createdate::date - ct.created::date) <= (SELECT posday FROM cfgdata)
	) THEN t.factmoney ELSE 0.00 END) AS pt_pos_money	-- POS业绩
	,SUM(CASE WHEN EXISTS(
		SELECT 1 FROM cc_customer ct 
		WHERE ct.code = t.customercode AND ct.org_id = t.org_id 
		AND (t.createdate::date - ct.created::date) <= (SELECT posday FROM cfgdata)
	) AND t.contracttype = 0 THEN 1 ELSE 0 END) AS pt_pos_num	-- POS单数
	,SUM(CASE WHEN EXISTS(
		SELECT 1 FROM cc_contract ct 
		WHERE ct.customercode = t.customercode AND ct.createdate::date  = t.createdate::date  
		AND ct.contracttype = 0 AND ct.type IN (0,5) AND ct.status >= 2 AND ct.org_id = t.org_id
	) THEN t.factmoney ELSE 0.00 END) AS ptnew_money	-- 新单业绩
	,SUM(CASE WHEN EXISTS(
		SELECT 1 FROM cc_contract ct 
		WHERE ct.customercode = t.customercode AND ct.createdate::date  = t.createdate::date  
		AND ct.contracttype = 0 AND ct.type IN (0,5) AND ct.status >= 2 AND ct.org_id = t.org_id
	) AND t.contracttype = 0 THEN 1 ELSE 0 END) AS ptnew_num	-- 新单单数
	,SUM(CASE WHEN EXISTS(
		SELECT 1 FROM cc_contract ct 
		WHERE ct.customercode = t.customercode AND ct.createdate::date = t.createdate::date 
		AND ct.contracttype = 0 AND ct.type IN (0,5) AND ct.status >= 2 AND ct.org_id = t.org_id
	) THEN t.factmoney ELSE 0.00 END) AS pt_ctn_money	-- 续课业绩
	,SUM(CASE WHEN EXISTS(
		SELECT 1 FROM cc_contract ct 
		WHERE ct.customercode = t.customercode AND ct.createdate::date = t.createdate::date
		AND ct.contracttype = 0 AND ct.type IN (0,5) AND ct.status >= 2 AND ct.org_id = t.org_id
	) AND t.contracttype = 0 THEN 1 ELSE 0 END) AS pt_ctn_num	-- 续课单数
FROM cc_contract t 
WHERE t.createdate::date = ${fld:date}::date 
AND t.type = 2 
and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
		UNION 
		SELECT g.org_id FROM hr_org g WHERE EXISTS(
			SELECT 1 FROM hr_staff_org so 
			INNER JOIN hr_staff f ON so.user_id = f.user_id 
			WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
