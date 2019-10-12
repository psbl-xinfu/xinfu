select 
	ct.type,
	ct.name,
	sum(card.factmoney) as factmoney
from cc_card card
inner join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
where card.status!=0 and card.isgoon=0 and card.org_id = ${def:org}
and card.created::date>=${fld:fdate} and card.created::date<=${fld:tdate}
GROUP BY ct.code,ct.type,ct."name" order by sum(card.factmoney) desc
