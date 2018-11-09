select
	card.startdate,
	card.enddate,
	cust.name,
	cust.mobile,
	card.created
from cc_card card
left join cc_customer cust on card.customercode = cust.code and card.org_id = cust.org_id
where card.isgoon=0 and card.code = ${fld:cardcode} and card.org_id=${def:org}