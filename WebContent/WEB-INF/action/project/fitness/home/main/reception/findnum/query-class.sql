select 
	count(1) as classnum
from cc_ptprepare
where status=2 and org_id = ${def:org}
and to_char(preparedate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 

