SELECT 
	'<input type="checkbox" class="duoxuan" name="danxuan" value="'||d.vc_customercode||'">' as application_id,
	v.vc_cardcode,	-- 卡号
	v.vc_name,	-- 姓名
	v.vc_sex,	-- 性别
	v.c_birthdate,	-- 生日
	v.vc_mobile,	-- 手机
	v.vc_cardname,	-- 卡类型
	v.vc_cardstatusname,	-- 卡状态
	v.c_enddate,	-- 截止日期
	v.vc_mcname,	-- 会籍
	v.vc_iusername,	-- 教练
	(SELECT COUNT(1) FROM e_inleft t WHERE t.vc_cardcode = v.vc_cardcode) AS incount,	-- 来访次数
	(v.f_pttotalcount - v.f_leftcount)::integer AS f_hadcount,	-- 上课节数
	v.vc_ptclassrate,	-- 上课频率
	v.f_leftcount::integer AS f_leftcount,	-- 剩余节数
	v.vc_lastdate,	-- 最新上课日期
	(current_date - v.vc_lastdate::date) AS unclassdays	-- 未上课天数
FROM v_customerhavept v 
LEFT JOIN e_card d ON d.vc_code =v.vc_cardcode 
LEFT JOIN e_customer r ON r.vc_code = d.vc_customercode 
WHERE v.i_ptfp IN (1,4) AND vc_lastdate IS NOT NULL AND f_leftcount > 0 
${filter}

AND (
	r.vc_club = '${def:tenantry}' OR 
	charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE r.vc_club = tenantry_id::varchar)) >= 1 
)