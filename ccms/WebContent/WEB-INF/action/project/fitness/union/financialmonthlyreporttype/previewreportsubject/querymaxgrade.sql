select 
	max(grade) as grade
from cc_report_subject
where 1=1
and org_id = ${def:org} and status = 1

	
