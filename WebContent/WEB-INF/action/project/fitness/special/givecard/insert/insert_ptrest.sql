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
select 
	nextval('seq_cc_ptrest')
	,${fld:customercode}
	,null
	,d.code	-- 私教类型
	,COALESCE(t.ptcount,0) AS ptcount	-- 购买课时
	,COALESCE(t.ptcount,0) AS ptcount	-- 剩余课时
	,0	-- 应收
	,0	-- ptmoney
	,0	-- f_ptfactfee
	,0 -- 课程单价
	,d.scale
	,NULL
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,5
	,NULL	-- 截止日期
	,t.org_id 
from cc_cardtype t
INNER JOIN (SELECT * FROM cc_ptdef WHERE reatetype = 1 AND org_id = ${def:org} AND status = 1 ORDER BY code LIMIT 1) AS d ON 1=1 
WHERE t.code = ${fld:cardtype} and t.org_id = ${def:org} 

