select 
	subjectname,
	(select count(1) from cc_report_subject 
		where pid = rs.tuid and org_id = ${def:org} and status=1) as count
from cc_report_subject rs
where rs.grade = 3 and rs.category = 1 and rs.status=1
and rs.org_id = ${def:org}
order by rs.showorder asc
