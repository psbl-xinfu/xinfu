select 
	cust.code,
    cust.name,
	cust.mobile,
	cust.moneycash,
	cust.moneygift
from cc_customer cust 
where cust.org_id = ${def:org} and cust.code = ${fld:cust}
