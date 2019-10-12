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
	,d.code	-- 私教类型
	,COALESCE(get_arr_value(t.relatedetail, 8), '0')::double precision	-- 购买课时
	,COALESCE(get_arr_value(t.relatedetail, 8), '0')::double precision	-- 剩余课时
	,${fld:normalmoney}	-- 应收
	,${fld:normalmoney}	-- ptmoney
	,0	-- f_ptfactfee
	,0 -- 课程单价
	,d.scale
	,NULL
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,5
	,NULL	-- 截止日期
	,t.org_id 
FROM cc_contract t 
INNER JOIN (SELECT * FROM cc_ptdef WHERE reatetype = 1 AND status = 1 AND org_id = ${def:org} ORDER BY code LIMIT 1) AS d ON 1=1 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org} 
AND 0::double precision < COALESCE(get_arr_value(t.relatedetail, 8), '0')::double precision 
