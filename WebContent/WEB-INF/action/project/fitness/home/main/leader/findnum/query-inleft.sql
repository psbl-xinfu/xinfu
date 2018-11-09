select 
	count(1) as inleftnum 
from cc_inleft 
where org_id = ${def:org} 
and to_char(indate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 

