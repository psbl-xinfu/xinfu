SELECT 
	descr, SUM(money) AS fee, COUNT(1) AS num 
FROM (
	SELECT 
		(
			CASE WHEN t.type = 1 AND t.item IN (10, 12, 13) THEN '会籍合同' 
			WHEN t.type = 2 THEN '私教合同' 
			WHEN t.item = 31 THEN '租柜合同' 
			WHEN t.item = 11 THEN '会员储值' 
			WHEN t.type = 3 AND t.item = 34 THEN '商品销售' 
			WHEN t.type = 3 AND t.item IN (33,34) THEN '单次消费' 
			ELSE '营运收入' END
		) AS descr, 
		t.money 
	FROM cc_finance t 
	WHERE t.created::date >= ${fld:fdate} AND t.created::date <= ${fld:tdate} 
	AND t.status != 0 AND t.money IS NOT NULL 
	and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
) AS tp 
GROUP BY descr
