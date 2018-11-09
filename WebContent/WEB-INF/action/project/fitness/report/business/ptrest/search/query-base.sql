SELECT
	concat('<input type="radio" name="danxuan" value="', t.code, '" code1="', 
		'" code2="', COALESCE(c.name,''), '" code3="', COALESCE(fp.name,''), '" code4="', COALESCE(t.ptleftcount,0.0), 
		'" code5="', COALESCE(t.ptenddate::varchar,''), '" code6="', COALESCE(p.is_delay,0), '">') as e_code,
	t.code as vc_code,
	c.code as cust_code,
	c.name as vc_name,	-- 姓名
	p.ptlevelname as vc_ptlevelname,	-- 私教类型
	(case t.pttype when 5 then '赠课' else 
		(select domain_text_cn from t_domain where "namespace"='Source' and domain_value = con.source)
	end) as i_pttype,	-- 来源1新买课、2场地开发、3续课、4转课、5赠课'
	t.pttotalcount::integer as f_pttotalcount,	-- 原始节数
	t.ptfee as f_ptfee,	-- 原价
	t.ptfactfee as f_ptfactfee,	-- 成交价
	t.ptleftcount::integer as f_ptleftcount,	-- 剩余节数
	t.ptnormalmoney::numeric(10,2) AS totalfee,-- 金额
	t.ptmoney,
	t.scale as f_scale,	-- 提成
	fp.name AS pt_name,	-- 私教
	t.created as c_itime,	-- 购买时间
	t.ptenddate as vc_ptenddate,--结束日期
	('${def:date}'::date - t.created::date) AS buyday,	-- 已购课天数
	(select count(1) from cc_ptrest_delay as pd where pd.ptrestcode=t.code and pd.org_id = t.org_id) as we, --已延期次数
	(case p.is_delay when 0 then '否' else '是' end) as delay,
	t.created 
FROM cc_ptrest t 
LEFT JOIN cc_contract con ON con.code = t.contractcode and con.org_id = t.org_id
INNER JOIN cc_customer c ON t.customercode = c.code and t.org_id = c.org_id
INNER JOIN cc_ptdef p ON t.ptlevelcode = p.code and t.org_id = p.org_id
INNER JOIN hr_staff fp ON t.ptid = fp.userlogin /**AND fp.i_status = 1*/ and t.org_id = fp.org_id
WHERE (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else t.createdby = '${def:user}' end)
AND t.ptleftcount > 0 AND t.pttype != 5 
${filter} 

AND c.org_id = ${def:org} 

UNION 

SELECT
	concat('<input type="radio" name="danxuan" value="', t.code, '" code1="', 
		'" code2="', COALESCE(c.name,''), '" code3="', COALESCE(staff.name,''), '" code4="', COALESCE(t.ptleftcount,0.0), 
		'" code5="', COALESCE(t.ptenddate::varchar,''), '" code6="', COALESCE(p.is_delay,0), '">') as e_code,
	t.code as vc_code,
	c.code as cust_code,
	c.name as vc_name,	-- 姓名
	p.ptlevelname as vc_ptlevelname,	-- 私教类型
	(case t.pttype when 5 then '赠课' else 
		(select domain_text_cn from t_domain where "namespace"='Source' and domain_value = con.source)
	end) as i_pttype,	-- 来源1新买课、2场地开发、3续课、4转课、5赠课'
	t.pttotalcount::integer as f_pttotalcount,	-- 原始节数
	t.ptfee as f_ptfee,	-- 原价
	t.ptfactfee as f_ptfactfee,	-- 成交价
	t.ptleftcount::integer as f_ptleftcount,	-- 剩余节数
	t.ptnormalmoney::numeric(10,2) AS totalfee,-- 金额
	t.ptmoney,
	t.scale as f_scale,	-- 提成
	staff.name AS pt_name,	-- 私教
	t.created as c_itime,	-- 购买时间
	t.ptenddate as vc_ptenddate,--结束日期
	('${def:date}'::date - t.created::date) AS buyday,	-- 已购课天数
	(select count(1) from cc_ptrest_delay as pd where pd.ptrestcode=t.code and pd.org_id = t.org_id) as we, --已延期次数
	(case p.is_delay when 0 then '否' else '是' end) as delay,
	t.created 
FROM cc_ptrest t 
LEFT JOIN cc_contract con ON con.code = t.contractcode and con.org_id = t.org_id
INNER JOIN cc_customer c ON t.customercode = c.code and t.org_id = c.org_id
INNER JOIN cc_ptdef p ON t.ptlevelcode = p.code and t.org_id = p.org_id 
LEFT JOIN hr_staff staff ON staff.userlogin = c.pt  
WHERE (case when exists(
		select 1 from hr_staff_skill hss 
		inner join hr_skill hs on hss.skill_id = hs.skill_id 
		where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1
	) then 1=1 else c.pt = '${def:user}' end
) 
AND t.ptleftcount > 0 AND t.pttype = 5 
${filter} 

AND c.org_id = ${def:org}


${orderby}
