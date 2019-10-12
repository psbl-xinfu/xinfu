select 
	count(1) as num
from cc_comm
where status = 1 and operatortype = 2
and org_id = ${def:org}
and to_char(created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 

