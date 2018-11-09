select 
	subjectname
from cc_report_subject rs
where rs.grade = 4 and rs.category = 1 and rs.status=1
and rs.org_id = ${def:org}
order by rs.showorder asc
