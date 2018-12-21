select 
	name as cust_name,
	mobile,
	moneygift,
	moneycash
from
	cc_customer
where code = ${fld:custcode} and org_id = ${def:org}