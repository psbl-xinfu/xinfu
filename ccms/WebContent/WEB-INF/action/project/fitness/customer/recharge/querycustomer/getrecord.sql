select
	code,
	name,
	moneycash,
	moneygift,
	(select max(enddate) from cc_card c where c.customercode = cc_customer.code and org_id = ${def:org}) as enddate
from cc_customer
where code = ${fld:cust}
and org_id = ${def:org}