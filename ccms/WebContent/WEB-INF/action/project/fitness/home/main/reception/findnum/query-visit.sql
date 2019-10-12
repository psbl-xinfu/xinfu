select 
	count(1) as visitnum
from cc_guest_prepare
where status=4 and org_id = ${def:org}
and to_char(preparedate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 

