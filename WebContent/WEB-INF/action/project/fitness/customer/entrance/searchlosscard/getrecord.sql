select
	card.code,
	card.status,
	(select ct.name from cc_cardtype ct where ct.code = card.cardtype and ct.org_id = ${fld:unionorgid}) as cardtype_name
from cc_customer cust
inner join cc_card card on card.customercode = cust.code and cust.org_id = card.org_id
where cust.code = ${fld:custall}
and cust.org_id = ${fld:unionorgid} and card.isgoon = 0 

