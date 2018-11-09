select
	card.code,
	card.customercode,--会员号
	cust.name,
	card.cardtype,
	card.enddate,
	(case when (card.enddate-{ts'${def:timestamp}'}::date)<0 then '0' end) as daysremain
from cc_card card
inner join cc_customer cust on card.customercode=cust.code and card.org_id =cust.org_id 
where 1=1 and (cust.name  like ${fld:vc_cardname} or card.code=${fld:vc_cardname})
 AND card.org_id = ${def:org}
 and card.isgoon = 0

limit  1