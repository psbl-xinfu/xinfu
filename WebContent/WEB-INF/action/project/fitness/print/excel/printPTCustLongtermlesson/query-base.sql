SELECT 
	'<input type="checkbox" class="duoxuan" name="danxuan" value="'||r.vc_code||'">' as application_id,
	v.vc_cardcode,	-- 卡号
	v.vc_name,	-- 姓名
	v.vc_sex,	-- 性别
	v.vc_mobile,	-- 手机
	v.vc_cardstatusname,	-- 卡状态
	v.c_enddate,	-- 截止日期
	v.vc_iusername,	-- 教练
	v.f_leftcount::integer AS f_leftcount,	-- 剩余节数
	v.vc_lastdate,	-- 最新上课日期
	CASE WHEN v.vc_lastdate IS NOT NULL THEN (current_date - v.vc_lastdate::date) ELSE NULL END AS unclassdays	-- 未上课天数
FROM v_customerhavept v 
INNER JOIN e_card d ON d.vc_code =v.vc_cardcode 
INNER JOIN e_customer r ON r.vc_code = d.vc_customercode 
WHERE v.vc_lastdate IS NOT NULL 
AND (current_date - v.vc_lastdate) > 2
${filter} 
AND (
	r.vc_club = '${def:tenantry}' OR 
	charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE r.vc_club = tenantry_id::varchar)) >= 1 
)
