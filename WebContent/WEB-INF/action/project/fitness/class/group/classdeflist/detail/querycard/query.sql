select 
	card.code,
	ct.name,
	cust.code as custcode
from cc_card card
left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
left join cc_customer cust on card.customercode = cust.code and cust.org_id = card.org_id
where cust.code = ${fld:cust}
and card.org_id = ${def:org} and card.isgoon = 0