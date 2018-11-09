SELECT 
	a.createdate as c_idate	-- 日期
	,SUM(a.factmoney)::numeric(10,2) AS sale_money	-- 销售金额
	,SUM(CASE WHEN a.contracttype = 3 THEN 0 ELSE 1 END) AS sale_num	-- 销售总订单数
	,SUM(CASE WHEN a.type IN (0,5) AND a.contracttype = 0 THEN 1 ELSE 0 END) AS newcust_num	-- 新入会单数
	,SUM(CASE WHEN a.contracttype IN (1,2) OR a.type = 6 THEN 1 ELSE 0 END) AS upgrade_num	-- 升级单数
	,SUM(CASE WHEN a.type IN (7,9,11) AND a.contracttype = 0 THEN 1 ELSE 0 END) AS ctn_num	-- 续约单数
	,SUM(CASE WHEN a.type = 5 AND a.contracttype = 0 THEN a.normalmoney ELSE 0.00 END) AS sale_deposit_money	-- 销售定金金额
	,SUM(CASE WHEN a.type = 5 AND a.contracttype = 0 THEN 1 ELSE 0 END) AS sale_deposit_num	-- 销售定金单数
FROM cc_contract a 
LEFT JOIN cc_customer c ON a.customercode = c.code and a.org_id = c.org_id 
WHERE to_char(a.createdate, 'yyyy-MM') = ${fld:month} 
AND a.type IN (0,1,5,6,7,9,11,12) 
AND a.status >= 2 
and (case when ${fld:org_id} is null then a.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
		UNION 
		SELECT g.org_id FROM hr_org g WHERE EXISTS(
			SELECT 1 FROM hr_staff_org so 
			INNER JOIN hr_staff f ON so.user_id = f.user_id 
			WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else a.org_id =${fld:org_id} end)
GROUP BY a.createdate 