select 
	count(1) as guestnum 
from cc_guest 
where org_id = ${def:org} 
and to_char(created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 