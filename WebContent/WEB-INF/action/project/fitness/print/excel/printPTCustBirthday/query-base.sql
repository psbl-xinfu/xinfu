WITH current_week AS (
	SELECT startdate, enddate, to_char(startdate, 'MMdd')::integer AS i_startdate, to_char(enddate, 'MMdd')::integer AS i_enddate
	FROM (
		SELECT 
			('${def:date}'::date - (current_weekday - 1)) AS startdate
			,('${def:date}'::date + (7 - current_weekday)) AS enddate
		FROM (SELECT EXTRACT(DOW FROM current_timestamp)::integer AS current_weekday) AS t1 
	) AS t2
)
SELECT 
	'<input type="checkbox" class="duoxuan" name="danxuan" value="'||a.vc_customercode||'">' as application_id,
	a.vc_customercode,	-- 会员号
	a.vc_cardcode,	-- 卡号
	a.vc_name,	-- 姓名
	a.vc_sex,	-- 性别
	a.c_birthdate,	-- 生日
	a.vc_mobile,	-- 手机号
	a.vc_cardname,	-- 卡类型
	a.vc_cardstatusname,	-- 卡状态
	a.vc_mcname,	-- 会籍
	a.vc_iusername,	-- 私教
	a.vc_ptclassrate,	-- 上课频率
	a.f_leftcount::integer AS f_leftcount,	-- 剩余节数
	a.vc_lastdate,	-- 最新上课日期
	case when vc_lastdate IS NOT NULL then ('${def:date}'::date - A.vc_lastdate) else null end AS f_leftdaycount	-- 未上课天数
FROM v_customerhavept a 
LEFT JOIN e_card d ON d.vc_code = a.vc_cardcode 
LEFT JOIN e_customer r ON r.vc_code = d.vc_customercode 
WHERE 1=1 
AND (
	CASE ${fld:_date} WHEN '1' THEN to_char(a.c_birthdate, 'MMdd') = to_char(current_timestamp, 'MMdd') /** 今日生日 */ 
	WHEN '2' THEN to_char(a.c_birthdate, 'MMdd')::integer >= (SELECT i_startdate FROM current_week) AND to_char(a.c_birthdate, 'MMdd')::integer <= (SELECT i_enddate FROM current_week)	/** 本周 */ 
	WHEN '3' THEN to_char(a.c_birthdate, 'MM') = to_char('${def:date}'::date, 'MM')	/** 本月 */ 
	WHEN '4' THEN (																																						
		(CASE WHEN ${fld:_start_date} IS NOT NULL THEN to_char(a.c_birthdate, 'MMdd')::integer >= to_char(${fld:_start_date}::date, 'MMdd')::integer ELSE TRUE END)
		 AND 
		(CASE WHEN ${fld:_end_date} IS NOT NULL THEN to_char(a.c_birthdate, 'MMdd')::integer <=to_char(${fld:_end_date}::date, 'MMdd')::integer ELSE TRUE END)
		 /** 指定日期 */
	) ELSE TRUE END
) 
AND (
	r.vc_club = '${def:tenantry}' OR 
	charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE r.vc_club = tenantry_id::varchar)) >= 1 
)

${filter}


ORDER BY a.c_birthdate 