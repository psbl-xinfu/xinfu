SELECT 
	'<input type="checkbox" class="duoxuan" name="danxuan" value="'||t1.vc_customercode||'">' as application_id,
	t1.vc_cardcode,	-- 卡号
	t3.vc_name,	-- 姓名
	(CASE t3.i_sex WHEN 0 THEN '女' WHEN 1 THEN '男' ELSE '未知' END) AS vc_sex,	-- 性别
	t3.vc_mobile,	-- 手机
	t2.vc_iuser,
	t4.name AS vc_iusername,	-- 教练
	t2.c_itime::date AS firstbuy,	-- 购课日期
	t5.vc_ptlevelname,	-- 私教类型
	t2.f_pttotalcount::integer,	-- 节数
	t2.f_ptnormalmoney,	-- 金额
	t2.f_ptleftcount::integer AS f_leftcount,	-- 剩余节数
	t1.vc_lastdate,	-- 最新上课日期
	(CURRENT_DATE - t1.vc_lastdate) AS unclassdays,	-- 未上课
	t1.vc_customercode 
FROM (
	SELECT p.vc_customercode, p.vc_cardcode, MIN(p.vc_code::bigint) AS min_ptrestcode
		,(
			SELECT g.c_itime::date FROM e_ptlog g 
			WHERE p.vc_customercode = g.vc_customercode 
			ORDER BY g.c_itime DESC LIMIT 1
		) AS vc_lastdate 
	FROM e_ptrest p 
	INNER JOIN e_ptdef d ON p.vc_ptlevelcode = d.vc_code 
	WHERE p.vc_contractcode IS NOT NULL AND p.vc_contractcode != '' 
	AND d.i_classtype = 1 
	${filter} 
	GROUP BY p.vc_customercode, p.vc_cardcode
) AS t1 
INNER JOIN e_ptrest t2 ON t2.vc_code = t1.min_ptrestcode::varchar 
INNER JOIN e_customer t3 ON t3.vc_code = t1.vc_customercode 
LEFT JOIN hr_staff t4 ON t2.vc_iuser = t4.userlogin 
LEFT JOIN e_ptdef t5 ON t2.vc_ptlevelcode = t5.vc_code 
ORDER BY t1.min_ptrestcode DESC 