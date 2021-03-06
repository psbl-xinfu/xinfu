select 
	r.subjectname,
	(case when r.fourcount=0 then 
		(case when r.threecount=0 then twocount else r.threecount end) 
		else r.fourcount end) as count
from 
(select 
	subjectname,
	--二级个数
	(select count(1) from cc_report_subject 
		where pid = rs.tuid and org_id = ${def:org} and status=1) as twocount,
	--三级个数
	(select count(1) from cc_report_subject where pid in 
	(select tuid from cc_report_subject 
		where pid = rs.tuid and org_id = ${def:org} and status=1) 
		and org_id = ${def:org} and status=1) as threecount,
	--四级个数
	(select count(1) from cc_report_subject where pid in 
		(select tuid from cc_report_subject where pid in
		(select tuid from cc_report_subject 
			where pid = rs.tuid and org_id = ${def:org} and status=1)
			 and org_id = ${def:org} and status=1)
		 and org_id = ${def:org} and status=1) as fourcount
from cc_report_subject rs
where rs.grade = 1 and rs.category = 1 and rs.status=1
and rs.org_id = ${def:org}
order by rs.showorder asc
) r
