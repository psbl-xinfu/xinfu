/**
SELECT a.c_atime::date AS c_idate	-- 日期
	,SUM(CASE WHEN a.vc_item != '未分类' THEN (a.f_money + a.f_moneyleft) ELSE 0.00 END) AS income_money	-- 营运收入
	,SUM(CASE WHEN a.vc_type = '3' AND a.vc_item = '未分类' THEN (a.f_money + a.f_moneyleft) ELSE 0.00 END) AS goods_money	-- 零售收入
FROM e_finance a 
WHERE to_char(a.c_atime, 'yyyy-MM') = ${fld:_month} AND a.i_status = 1 
GROUP BY a.c_atime::date
*/
/**	营运收入：指一些停卡，转卡，转店，补卡，等非会籍非私教非零售的收入	*/
SELECT c_idate, SUM(yyincome_money) AS yyincome_money FROM (
	/** 转卡 */
	SELECT t.createdate::date AS c_idate, t.factmoney AS yyincome_money 
	FROM cc_contract t 
	WHERE to_char(t.createdate, 'yyyy-MM') = ${fld:month}
	and (case when ${fld:org_id} is null then t.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else t.org_id =${fld:org_id} end)
	AND t.type = 10 AND t.status >= 2 
	
	UNION 
	/** 停卡 */
	SELECT s.created::date AS c_idate, s.money AS yyincome_money 
	FROM cc_savestopcard s 
	WHERE to_char(s.created, 'yyyy-MM') = ${fld:month} 
	AND s.status != 0 AND s.money > 0 
	and (case when ${fld:org_id} is null then s.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else s.org_id =${fld:org_id} end)
	
	UNION 
	/** 补卡 */
	SELECT a.created::date AS c_idate, (COALESCE(a.money,0.00) + COALESCE(a.moneyleft,0.00)) AS yyincome_money 
	FROM cc_finance a 
	WHERE to_char(a.created, 'yyyy-MM') = ${fld:month} 
	AND a.type = 1 AND a.item = 40 AND a.status = 1
	and (case when ${fld:org_id} is null then a.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else a.org_id =${fld:org_id} end)
) AS t 
GROUP BY c_idate
