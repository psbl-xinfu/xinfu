SELECT 
	NULL::integer AS day
	,NULL::date AS c_idate
	/**,NULL::numeric(10,2) AS income_money	-- 总收入*/
	,NULL::numeric(10,2) AS sale_money	-- 销售金额
	,NULL::bigint AS sale_num	-- 销售总订单数
	,NULL::bigint AS newcust_num	-- 新入会单数
	,NULL::bigint AS upgrade_num	-- 升级单数
	,NULL::bigint AS ctn_num	-- 续约单数
	,NULL::numeric(10,2) AS sale_deposit_money	-- 销售定金金额
	,NULL::bigint AS sale_deposit_num	-- 销售定金单数
	,NULL::bigint AS visit_num -- 访客总数
	,NULL::bigint AS prepare_visit_num	-- 预约总数
	,NULL::bigint AS prepare_success_num	-- 预约出现数
	,NULL::bigint AS wi	-- WI 访客
	,NULL::bigint AS di	-- DI
	,NULL::bigint AS br	-- BR 会员介绍
	,NULL::numeric(10,2) AS pt_money	-- 私教业绩
	,NULL::numeric(10,2) AS pt_pos_money	-- POS业绩
	,NULL::bigint AS pt_pos_num	-- POS单数
	,NULL::numeric(10,2) AS ptnew_money	-- 新单业绩
	,NULL::bigint AS ptnew_num	-- 新单单数
	,NULL::numeric(10,2) AS pt_ctn_money	-- 续课业绩
	,NULL::bigint AS pt_ctn_num	-- 续课单数
	,NULL::bigint AS pi_prepare_num	-- P1预约人数
	,NULL::bigint AS pi_prepare_success_num	-- P1出现人数
	,NULL::bigint AS pt_prepare_num	-- 私教课预约数
	,NULL::bigint AS pt_prepare_success_num	-- 私教课出现数
	,NULL::bigint AS cust_inleft_num	-- 会员入场数
	,NULL::bigint AS class_num	-- 团操上课人数
	,NULL::bigint AS br_num	-- BR名单数
	,NULL::numeric(10,2) AS yyincome_money	-- 营运收入
	,NULL::numeric(10,2) AS goods_money	-- 零售收入
FROM dual 
WHERE 1 = 2
