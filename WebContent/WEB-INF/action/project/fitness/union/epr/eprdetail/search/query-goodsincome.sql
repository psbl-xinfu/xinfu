/** 零售收入：商品销售、单次消费、场地租用 */
SELECT SUM(goods_money) AS goods_money FROM (
	/** 商品销售 */
	SELECT t.factmoney AS goods_money 
	FROM cc_leave_stock t 
	WHERE t.created::date = ${fld:date}::date
	and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
	AND t.status != 0 
	
	UNION 
	/** 单次消费 */
	SELECT t.money AS goods_money 
	FROM cc_singleitem t 
	WHERE t.collectdate::date = ${fld:date}::date 
	and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
	AND t.status >= 2 
	
	UNION 
	/** 场地租用 */
	SELECT t.factmoney AS goods_money 
	FROM cc_siteusedetail t 
	INNER JOIN cc_sitedef s ON s.code = t.sitecode and t.org_id = s.org_id
	WHERE t.opentime::date = ${fld:date}::date
	and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
	AND (t.status = 2 or t.status = 3)
) AS t 
