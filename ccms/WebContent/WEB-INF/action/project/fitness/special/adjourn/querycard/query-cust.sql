select 
	cust.mobile,
	cust.code as cust_code,
	cust.name as cust_name
from cc_customer cust
where cust.code = ${fld:cust}
and cust.org_id = ${def:org}