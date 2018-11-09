select 
	startdate,
	enddate,
	nowcount,
	(select name from cc_cardtype where code = cardtype and cc_cardtype.org_id = ${def:org}) as typename,
	(select mobile from cc_customer where code = customercode and cc_customer.org_id = ${def:org} ) as mobile
from cc_card
where code = (select cardcode from cc_classprepare where code = ${fld:id} and org_id = ${def:org})
and org_id = ${def:org}