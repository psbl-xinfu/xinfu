select 
	ct.type,
	count(1) as num
from cc_card card
inner join cc_cardtype ct on card.cardtype = ct.code and card.org_id= ct.org_id
where card.status!=0 and card.isgoon=0
and card.created::date>=${fld:fdate} and card.created::date<=${fld:tdate}
and ct."type" in (0, 1) and card.org_id = ${def:org}
GROUP BY ct.type

