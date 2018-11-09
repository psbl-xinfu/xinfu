SELECT 
	'<input type="checkbox" class="duoxuan" name="danxuan" value="'||r.vc_code||'">' as application_id,
	v.vc_cardcode,	-- 卡号
	v.vc_name,	-- 姓名
	v.vc_sex,	-- 性别
	v.vc_mobile,	-- 手机
	v.vc_cardstatusname,	-- 卡状态
	v.c_enddate,	-- 截止日期
	(v.c_enddate - current_date) AS leftdays,	-- 剩余天数
	v.vc_iusername,	-- 教练
	v.vc_ptclassrate,	-- 上课频率
	v.f_leftcount::integer AS f_leftcount,	-- 剩余节数
	v.vc_lastdate,	-- 最新上课日期
	CASE WHEN v.vc_lastdate IS NOT NULL THEN (current_date - v.vc_lastdate::date) ELSE NULL END AS unclassdays	-- 未上课天数
FROM v_customerhavept v 
LEFT JOIN e_card d ON d.vc_code =v.vc_cardcode 
LEFT JOIN e_customer r ON r.vc_code = d.vc_customercode 
WHERE v.c_enddate < current_date 
AND v.i_cardstatus != 0 AND v.i_cardstatus != 2 
${filter} 
AND (
	r.vc_club = '${def:tenantry}' OR 
	charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE r.vc_club = tenantry_id::varchar)) >= 1 
)
