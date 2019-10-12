select 
	name as cust_name,
	mobile,
--	moneygift,
	moneycash
from
	cc_customer
where code = ${fld:cust} and org_id = ${def:org}