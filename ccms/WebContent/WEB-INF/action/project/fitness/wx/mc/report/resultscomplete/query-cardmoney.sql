select 
	created::date as createdate,
	sum(card.factmoney) as factmoney
from cc_card card
inner join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
where card.status!=0 and card.isgoon=0 and card.org_id = ${def:org}
and to_char(card.created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
GROUP BY created::date order by created::date asc
