select 
	cust.mobile,
	cust.code as cust_code,
	cust.name as cust_name,
	moneycash,
	moneygift
from cc_customer cust
where cust.code = (select customercode from cc_card where code = ${fld:code} and isgoon = 0 and org_id = ${def:org})
and cust.org_id = ${def:org}