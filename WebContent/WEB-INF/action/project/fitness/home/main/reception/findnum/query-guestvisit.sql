select 
	count(1) as guestvisitnum
from cc_guest_visit
where org_id = ${def:org} 
and to_char(visitdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
