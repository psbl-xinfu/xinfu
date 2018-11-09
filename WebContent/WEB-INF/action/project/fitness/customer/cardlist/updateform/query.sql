select 
	card.code,
	ct.name,
	card.factmoney,
	card.count,
	card.nowcount,
	card.startdate,
	card.enddate,
	ct.type,
	(case when ct.type=0 then '时效卡' when ct.type = 1 then '记次卡' end) as cardleibie,
	card.starttype,
	card.status,
	card.stopdays,
	card.nowcount,
	card.remark
from cc_card card
left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
where card.code = ${fld:cardcode} and card.org_id = ${def:org}
and card.isgoon = 0