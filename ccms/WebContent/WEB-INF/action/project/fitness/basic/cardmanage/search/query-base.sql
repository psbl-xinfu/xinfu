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
  	CASE isoffseason WHEN 0 THEN '是' ELSE '否' END as vc_isoffseason,
  	(select category_name from cc_cardcategory ct where ct.code=cc_cardtype.cardcategory and ct.org_id = ${def:org}) as vc_cardtype,
  	(select cardfee from cc_cardtype_fee cf where cf.cardtype=cc_cardtype.cardcategory and cf.org_id = ${def:org} limit 1) as f_cardfee
from cc_cardtype
where 1=1 
	and org_id = ${def:org}
${filter}
