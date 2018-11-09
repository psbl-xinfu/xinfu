SELECT
	con.code AS vc_contractcode,
	cust.name as vc_name,
	(CASE cust.sex WHEN 0 THEN '女' WHEN 1 THEN '男' ELSE '未知' END) AS i_sex,
	cust.mobile as vc_mobile,
	con.normalmoney as f_normalmoney,
	con.factmoney as f_factmoney,
	con.stage_times as i_stage_times,
	(
		select max(t2.stage_times_pay) from cc_contract t2 
		where (t2.relatecode = con.code or t2.code = con.code) and t2.org_id = con.org_id and t2.status != 0 and t2.isaudit != 3 
	) as i_stage_times_pay,
	con.normalmoney - con.factmoney - (
		COALESCE ((
			SELECT SUM (t1.factmoney) FROM cc_contract t1 
			WHERE t1.relatecode = con.code AND t1.status >= 2 and t1.org_id = con.org_id
		),0.00)
	)::numeric(10,2) AS amount_owe,
	(
		CASE WHEN (con.stage_times - con.stage_times_pay) = 0 THEN 0
		ELSE (
				con.normalmoney - con.factmoney - (
					COALESCE ((
						SELECT SUM (t1.factmoney) FROM cc_contract t1 
						WHERE t1.relatecode = con.code AND t1.status >= 2 and t1.org_id = con.org_id
					),0.00)
				)
			) / (con.stage_times - con.stage_times_pay-(
						SELECT count(1) FROM cc_contract t1 
						WHERE t1.relatecode = con.code AND t1.status >= 2 and t1.org_id = con.org_id
					))
		END
	)::numeric(10,2) AS should_resver,
	con.createdate as c_idate,
	(select name from hr_staff where userlogin=con.createdby) as vc_iuser 
FROM cc_contract con
LEFT JOIN cc_customer cust ON con.customercode = cust.code and con.org_id = cust.org_id 
WHERE 1 = 1 
AND con.contracttype != 3 AND con.stage_times > 1 
AND con.stage_times > con.stage_times_pay AND con.status >= 2 
AND con.normalmoney > con.factmoney + COALESCE (
	(
		SELECT SUM (t1.factmoney) FROM cc_contract t1 
		WHERE t1.relatecode = con.code AND t1.status >= 2 and t1.org_id = con.org_id
	),
	0.00
) 
and con.org_id = ${def:org}
${filter}

order by con.createdate desc , con.createtime desc
