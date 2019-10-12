select 
	cust.mobile
from cc_customer cust
where cust.code = ${fld:cust}
and cust.org_id = ${def:org}