select
	card.code,
	ctp.name as name,
	ctp.singlediscount as discount
from
	cc_card card
left join cc_cardtype ctp on ctp.code=card.cardtype and ctp.org_id=card.org_id
where card.isgoon = 0 
and card.status = 1 
and card.org_id = ${def:org}
and card.customercode =${fld:cust}