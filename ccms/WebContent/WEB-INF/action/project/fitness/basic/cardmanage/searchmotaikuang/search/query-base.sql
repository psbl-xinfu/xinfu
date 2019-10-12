select	
 	code,-- 编号
  	name,--名称
  	membercount,--卡属性
  	type,--卡类别
 	isoffseason,--是否为淡季卡
 	item,--消费项目
 	daycount,--有效天数
 	allowcount,--不限或1次
 	limitswimtime::integer,--几次
 	freebathcount::integer,--免费洗几次
 	scale,--提成
 	giveday,--额外赠送 天
 	ptcount,--额外送  节
	savedaycount,--可存卡
	status,--状态
 	remark,--备注
 	count,--有效次数
  	moneyleft,--现金
	CASE status WHEN 0 THEN '无效' ELSE '有效' END as i_status,
  	(select code from cc_cardcategory ct where ct.code=cc_cardtype.cardcategory and ct.org_id = ${def:org}) as vc_cardtype,--卡分类
  	(select cardfee from cc_cardtype_fee cf where cf.cardtype=cc_cardtype.code and cf.org_id = ${def:org} LIMIT 1) as f_cardfees--卡价格
  from cc_cardtype
where 1=1 
	and org_id = ${def:org}
${filter}