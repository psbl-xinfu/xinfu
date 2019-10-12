SELECT 
	t.code as vc_code	-- 合同号
	,cust.name as vc_name	-- 姓名
	,cust.mobile as vc_mobile
	,(CASE cust.sex WHEN 0 THEN '女' WHEN 1 THEN '男' ELSE '未知' END) AS vc_sex
	,cust.card as vc_id
	,cust.addr as vc_addr
	,t.inimoney as f_inimoney	-- 原价
	,t.normalmoney as f_normalmoney	-- 应收
	,t.factmoney as f_factmoney
	,(t.normalmoney - t.factmoney) AS f_leftmoney	-- 尚欠
	,t.discounttype as i_discounttype	-- 折扣
	,t.collectdate as c_adate
	,t.pay_detail
	,f.cardcode as vc_cardcode 
	,t.contracttype as i_contracttype
	,t.type as i_type
	,t.remark as vc_remark
	,COALESCE(t.stage_times,0) AS i_stage_times
	,COALESCE(t.stage_times_pay,0) AS i_stage_times_pay,
	get_arr_value(t.relatedetail, 1) as vc_cardcode
FROM cc_contract t 
INNER JOIN cc_finance f ON t.code = f.operationcode 
left join cc_customer cust on cust.code = t.customercode
WHERE t.code = ${fld:vc_code} and t.org_id = ${def:org} 

