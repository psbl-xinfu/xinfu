-- 双击列表弹出相应的查询界面
SELECT
	finance.code as vc_code	-- 收据号
	,hs.name AS v_salesname	-- 销售
	,finance.cardcode as vc_cardcode	-- 卡号
	,cust.name AS vc_customername	-- 姓名
	,finance.type as vc_type
	,CASE finance.type WHEN '1' THEN '会员卡' WHEN '2' THEN '私教' WHEN '3' THEN '杂项' END AS vc_typename	-- 收入类型
	,finance.detail as vc_detail	-- 收入类型
	,finance.premoney as f_premoney	-- 预付款
	,finance.money as f_money	-- 收入
	,finance.moneyleft as f_moneyleft	-- 欠款
	
	,0 as f_cash	-- 现金
	,0 as f_pos	-- POS
	,0 as f_check	-- 支票
	,0 as f_card	-- 储值卡
	,0 as f_other	-- 其他

	,staff.name AS vc_ausername	-- 收银
	,finance.created::date AS c_adate	-- 收银日期
	,finance.remark as vc_remark	-- 备注
	,finance.operationcode as vc_operationcode
	,finance.item as vc_item 
FROM cc_finance finance
LEFT JOIN hr_staff hs on finance.salesman = hs.userlogin and finance.org_id = hs.org_id
LEFT JOIN cc_customer cust on finance.customercode = cust.code and finance.org_id = cust.org_id
LEFT JOIN hr_staff staff on finance.createdby = staff.userlogin and finance.org_id = staff.org_id
LEFT JOIN cc_ptdef pd on finance.ptlevelcode = pd.code and finance.org_id = pd.org_id
WHERE finance.status = 1 

${filter}

AND finance.org_id = ${def:org}

ORDER BY finance.code DESC
