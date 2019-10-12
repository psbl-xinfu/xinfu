select 
	count(1) as custnum 
from cc_contract 
where org_id = ${def:org} and type = 0 and status!=0
and to_char(createdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 

