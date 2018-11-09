select
	count(1) as num
from cc_ptlog
where customercode = ${fld:customercode} and org_id = ${def:org}
and status=1