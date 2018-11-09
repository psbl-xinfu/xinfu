select 
	c.code
	,(select name from cc_cardtype where code = c.cardtype and org_id = ${def:org}) as name
	,cust.mobile
	,cust.name as custname
from cc_card c  
left join cc_customer cust on c.customercode = cust.code and c.org_id =cust.org_id 
where c.org_id = ${def:org} 
and c.isgoon = 0
and c.status != 0 
${filter}