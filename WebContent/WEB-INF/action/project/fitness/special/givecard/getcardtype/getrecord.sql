select
	ct.count,--有效ci
	 (select cf.cardfee from cc_cardtype_fee cf where cf.cardtype=ct.code and cf.org_id = ${def:org}) as f_cardfee,--卡价格
	ct.name,--有效天
	ct.daycount,--有效天
	ct.giveday,--赠送
	ct.moneyleft--现金/卡余
from cc_cardtype  ct
where ct.code=${fld:cardtypecode} and org_id = ${def:org}
   