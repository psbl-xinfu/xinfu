select 
	card.code,
	ct.name
from cc_card card
left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
where card.customercode = (select customercode from cc_card where code=
(select cardcode from cc_classprepare where code = ${fld:id} and org_id = ${def:org}) and org_id = ${def:org}) and 
card.org_id = ${def:org}