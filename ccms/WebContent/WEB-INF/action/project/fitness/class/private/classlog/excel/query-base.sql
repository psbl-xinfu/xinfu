SELECT 
	(select name from cc_customer where code = get_arr_value(op.relatedetail,0) and org_id = ${def:org}) AS old_name,	-- 转课人      
	(select name from cc_customer where code = get_arr_value(op.relatedetail,1) and org_id = get_arr_value(op.relatedetail,6)::int) AS new_name,	-- 新会员姓名      
	pd.ptlevelname,	
	get_arr_value(op.relatedetail,4) AS ptcount,	-- 转课节数
	(select name from hr_staff where userlogin = get_arr_value(op.relatedetail,5) and org_id = get_arr_value(op.relatedetail,6)::int) AS old_ptname,	-- 转课后PT教练
	(select name from hr_staff where userlogin = pr.ptid and org_id = ${def:org}) AS new_ptname,	-- 转课前PT教练
	op.createdate || ' ' || op.createtime AS trtime,-- 转课时间
	(case when get_arr_value(op.relatedetail,6)::int=op.org_id then '否' else '是' end) as isunion
FROM cc_operatelog op 
LEFT JOIN cc_ptrest pr ON pr.code = get_arr_value(op.relatedetail,2) and op.org_id = pr.org_id   --私教级别,原私教
LEFT JOIN cc_customer cust on pr.customercode = cust.code and pr.org_id = cust.org_id
LEFT JOIN cc_ptdef pd ON pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
WHERE op.opertype = '40' and op.org_id = ${def:org}
${filter}

order by op.createdate desc,op.createdate desc
