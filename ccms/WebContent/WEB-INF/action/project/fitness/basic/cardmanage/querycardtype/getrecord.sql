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
  	(select category_name from cc_cardcategory ct where ct.code=cc_cardtype.code and ct.org_id = ${def:org}) as vc_cardtype,--卡分类
  	(select cardfee from cc_cardtype_fee cf where cf.cardtype=cc_cardtype.code and cf.org_id = ${def:org}) as f_cardfee--卡价格
from cc_cardtype
where
  	code=${fld:in_vc_code}
  and org_id = ${def:org}
  