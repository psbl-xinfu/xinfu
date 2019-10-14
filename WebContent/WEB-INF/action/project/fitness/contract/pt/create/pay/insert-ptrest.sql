INSERT INTO cc_ptrest(
	code
	,customercode
	,contractcode
	,ptlevelcode
	,pttotalcount
	,ptleftcount
	,ptnormalmoney
	,ptmoney
	,ptfactfee
	,ptfee
	,scale
	,ptid
	,createdby
	,created
	,pttype
	,ptenddate
	,org_id
) 
SELECT 
	nextval('seq_cc_ptrest')
	,t.customercode
	,t.code
	,get_arr_value(t.relatedetail, 1)	-- 私教类型
	,COALESCE(get_arr_value(t.relatedetail, 2), '0')::double precision	-- 购买课时
	,COALESCE(get_arr_value(t.relatedetail, 2), '0')::double precision	-- 剩余课时
	,${fld:normalmoney}	-- 应收
	,${fld:normalmoney}	-- ptmoney
	,(${fld:normalmoney}/get_arr_value(t.relatedetail, 2)::int)::float ptfactfee 	-- f_ptfactfee
	,(SELECT d.ptfee FROM cc_ptdef d WHERE d.code = get_arr_value(t.relatedetail, 1) and d.org_id = t.org_id) -- 课程单价
	,(SELECT d.scale FROM cc_ptdef d WHERE d.code = get_arr_value(t.relatedetail, 1) and d.org_id = t.org_id)
	,get_arr_value(t.relatedetail, 8)
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,1
	,COALESCE(get_arr_value(t.relatedetail, 3), null)::date	-- 截止日期
	,t.org_id 
FROM cc_contract t 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org}
