select 
	code as cust_code,
	name as cust_name,
	mobile,
	moneygift,
	moneycash
from
	cc_customer where 
mobile = ${fld:mobile} and org_id = ${def:org}
UNION
select 
	code as cust_code,
	name as cust_name,
	mobile,
	null as moneygift,
	null as moneycash
from
	cc_guest where 
mobile = ${fld:mobile} and org_id = ${def:org} ORDER BY moneygift,moneycash desc  limit 1