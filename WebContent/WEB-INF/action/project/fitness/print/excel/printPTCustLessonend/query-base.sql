SELECT 
	'<input type="checkbox" class="duoxuan" name="danxuan" value="'||A.vc_customercode||'">' as application_id,
	A.vc_customercode,	-- 会员编号
	A.vc_cardcode,	-- 卡号
	A.vc_name,	-- 姓名
	CASE A.i_sex WHEN 0 THEN '女' WHEN 1 THEN '男' ELSE '不详' END AS vc_sex,	-- 性别
	A.vc_mobile,	-- 手机号
	D.name AS ptname,	-- 教练姓名
	B.vc_contractcode,	-- 合同号
	B.c_buytime::date AS c_buytime,	-- 购课日期
	B.vc_ptlevelname,	-- 私教类型
	B.f_pttotalcount::integer AS f_pttotalcount,	-- 原始节数
	B.f_ptnormalmoney::numeric(10,2) AS f_ptnormalmoney,	-- 购课金额
	B.vc_pttype,	-- 来源
	B.c_endtime::Date AS c_endtime,	-- 完成日期
	C.ptleftcount::integer AS ptleftcount -- 剩余节数
FROM v_customer A 
LEFT JOIN e_card e ON e.vc_code =A.vc_cardcode 
LEFT JOIN e_customer r ON r.vc_code = e.vc_customercode 
INNER JOIN (
	SELECT A.vc_customercode, A.vc_iuser, C.vc_contractcode, C.c_itime AS c_buytime, B.vc_ptlevelname, C.f_pttotalcount, C.f_ptnormalmoney
		,CASE C.i_pttype WHEN 1 THEN '新买课' WHEN 2 THEN '场地开发' WHEN 3 THEN '续课' WHEN 4 THEN '转课' ELSE '赠课' END AS vc_pttype, A.c_itime AS c_endtime 
	FROM e_ptlog A 
	INNER JOIN e_ptdef B ON A.vc_ptlevelcode = B.vc_code 
	INNER JOIN e_ptrest C ON C.vc_code = A.vc_ptcode 
	WHERE B.i_classtype = 1 AND A.f_leftcount = 0 
	AND (
		C.vc_club = '${def:tenantry}' OR 
		charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE C.vc_club = tenantry_id::varchar)) >= 1 
	)
) AS B ON A.vc_customercode = B.vc_customercode 
INNER JOIN (
	SELECT A.vc_customercode, A.vc_iuser, SUM(A.f_ptleftcount) AS ptleftcount 
	FROM e_ptrest A 
	INNER JOIN e_ptdef B ON A.VC_PTLEVELCODE=B.VC_CODE 
	WHERE B.i_classtype = 1 
	AND (
		A.vc_club = '${def:tenantry}' OR 
		charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE A.vc_club = tenantry_id::varchar)) >= 1 
	)
	GROUP BY A.vc_customercode, A.vc_iuser
) AS C ON A.vc_customercode = C.vc_customercode AND B.vc_iuser = C.vc_iuser  
LEFT JOIN hr_staff D ON b.vc_iuser = D.userlogin 
WHERE 1=1 
	${filter}
ORDER BY B.c_endtime