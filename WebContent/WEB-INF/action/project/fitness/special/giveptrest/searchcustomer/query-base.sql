select 
	cust.code,
    cust.name,
	cust.mobile
from cc_customer cust 
where cust.org_id = ${def:org} and cust.code = ${fld:cust}
