SELECT 
	t.vc_cardcode,	-- 卡号
	c.vc_name,	-- 姓名
	p.vc_ptlevelname,	-- 私教类型
	CASE t.i_pttype WHEN 1 THEN '新买课' WHEN 2 THEN '场地开发' WHEN 3 THEN '续课' WHEN 4 THEN '转课' WHEN 5 THEN '赠课' END i_pttype,	-- 来源
	t.f_pttotalcount::integer,	-- 原始节数
	t.f_ptfee,	-- 原价
	t.f_ptfactfee,	-- 成交价
	t.f_ptleftcount::integer,	-- 剩余节数
	(t.f_ptleftcount::double precision*t.f_ptfactfee::double precision)::numeric(10,2) AS totalfee,-- 金额
	t.f_scale,	-- 提成
	t.vc_iuser,
	fp.name AS vc_pt,	-- 私教
	t.c_itime,	-- 购买时间
	(current_date - t.c_itime::date) AS buyday	-- 已购课天数
FROM e_ptrest t 
INNER JOIN e_customer c ON t.vc_customercode = c.vc_code 
INNER JOIN e_ptdef p ON t.vc_ptlevelcode = p.vc_code 
LEFT JOIN e_card d ON d.vc_code = t.vc_cardcode AND d.i_isgoon = 0 and d.i_status != 0 
LEFT JOIN hr_staff fp ON c.vc_pt = fp.userlogin 
LEFT JOIN hr_staff f ON t.vc_customercode = f.userlogin 
WHERE t.f_ptleftcount > 0 
${filter} 
AND (
	c.vc_club = '${def:tenantry}' OR 
	charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE c.vc_club = tenantry_id::varchar)) >= 1 
)
