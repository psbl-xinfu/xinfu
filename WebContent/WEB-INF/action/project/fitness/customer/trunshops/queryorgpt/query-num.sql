select
	count(1) as num
from cc_customer
where mobile = (select mobile from cc_customer where code=${fld:custcode})
and org_id = ${fld:org_id}