select 
	op.*,
	hs.name as old_ptname,
	custzero.name as old_name,
	custone.name as new_name
from
(SELECT 
	get_arr_value(op.relatedetail,0) as custcodezero,
	get_arr_value(op.relatedetail,1) as custcodeone,
	pd.ptlevelname,	
	get_arr_value(op.relatedetail,4) AS ptcount,	-- 转课节数
	get_arr_value(op.relatedetail,5) as huserlogin,
	get_arr_value(op.relatedetail,6)::int as horg,
	(select name from hr_staff where userlogin = pr.ptid and org_id = ${def:org}) AS new_ptname,	-- 转课前PT教练
	op.createdate || ' ' || op.createtime AS trtime,-- 转课时间
	(case when get_arr_value(op.relatedetail,6)::int=op.org_id then '否' else '是' end) as isunion,
	op.createdate,
	op.createtime
FROM cc_operatelog op 
LEFT JOIN cc_ptrest pr ON pr.code = get_arr_value(op.relatedetail,2) and op.org_id = pr.org_id   --私教级别,原私教
LEFT JOIN cc_ptdef pd ON pr.ptlevelcode = pd.code and pr.org_id = pd.org_id

WHERE op.opertype = '40' and op.org_id = ${def:org}
${filter}

${orderby}
) as op
left join hr_staff hs on hs.userlogin = op.huserlogin and hs.org_id = op.horg
left join cc_customer custzero on custzero.code = op.custcodezero and custzero.org_id = ${def:org}
left join cc_customer custone on custone.code = op.custcodeone and custone.org_id = op.horg
${orderby}
