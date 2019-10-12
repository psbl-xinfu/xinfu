select
 	code,
  	name,
  	membercount,
  	type,
 	isoffseason as vc_isoffseason,
 	item,
 	daycount,
 	allowcount,
 	limitswimtime,
 	freebathcount,
 	scale,
 	giveday,
 	ptcount,
	savedaycount,
	status,
 	remark,
 	count,
  	moneyleft,
  (select category_name from cc_cardcategory ct where ct.code=cc_cardtype.code and ct.org_id = ${def:org}) as vc_cardtype,--卡分类
  (select cardfee from e_cardfee cf where cf.cardtype=cc_cardtype.code and cf.org_id = ${def:org}) as f_cardfee--卡价格
from cc_cardtype
where
  vc_code=${fld:id}
  and org_id = ${def:org}