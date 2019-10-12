select 
	count(1) as notrenewalnum
from cc_contract t where t.createdate>=${fld:fdate} and t.createdate<=${fld:tdate}
and (t.type=0 or (t.type=7 or t.type=9 or t.type=11)) and org_id = ${def:org}
and not EXISTS(
	select 1 from cc_customer cust
	left join cc_contract ct on cust.code = ct.customercode and cust.org_id = ct.org_id
	where (ct.type=0 or (ct.type=7 or ct.type=9 or ct.type=11))
	and ct.createdate<t.createdate and cust.org_id = ${def:org}
	and t.customercode = cust.code
)
