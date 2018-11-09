select 
	(count(1)/((to_char({ts '${def:timestamp}'},'yyyy-MM-dd')::date-to_char({ts '${def:timestamp}'},'yyyy-MM-01')::date)+1)) as inleftnummean 
from cc_inleft 
where org_id = ${def:org} 
and to_char(indate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 

