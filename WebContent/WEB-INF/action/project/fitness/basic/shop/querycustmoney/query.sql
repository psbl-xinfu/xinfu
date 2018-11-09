select 
	cust.code,
	cust.name,
	cust.mobile,
	cust.moneycash,
	cust.moneygift,
	(select drinkdiscount from cc_cardtype where code = card.cardtype and org_id = ${def:org}) as drinkdiscount
from cc_customer cust
left join cc_card card on cust.code = card.customercode and cust.org_id = card.org_id
where card.code = ${fld:cardcode} and card.isgoon = 0
and cust.org_id = ${def:org}