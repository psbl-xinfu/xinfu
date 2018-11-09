select 
	max(enddate) as enddate
from cc_card card
inner join cc_customer cust on card.customercode = cust.code and card.org_id = cust.org_id
where cust.code = ${fld:custcode} and card.isgoon = 0 and card.status=1
and cust.org_id = ${def:org}