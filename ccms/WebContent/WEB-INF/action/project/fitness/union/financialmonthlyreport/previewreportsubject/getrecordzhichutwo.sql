select 
	r.subjectname,
	(case when r.fourcount=0 then threecount else r.fourcount end) as count,
	--判断二级名称是否为空，为空返回pid（一级id）
	(case when subjectname is null or subjectname = '' then pid else tuid end) as tdid,
	category
from 
(select 
	tuid,
	category,
	subjectname,
	pid,
	--三级个数
	(select count(1) from cc_report_subject 
		where pid = rs.tuid and org_id = rs.org_id and status=1) as threecount,
	--四级个数
	(select count(1) from cc_report_subject where pid in 
	(select tuid from cc_report_subject 
		where pid = rs.tuid and org_id = rs.org_id and status=1) 
		and org_id = rs.org_id and status=1) as fourcount
from cc_report_subject rs
where rs.grade = 2 and rs.category = 1 and rs.status=1
and rs.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
	UNION 
	SELECT g.org_id FROM hr_org g 
		WHERE EXISTS(SELECT 1 FROM hr_staff_org so WHERE so.userlogin = '${def:user}' AND so.org_id = g.org_id))
order by rs.showorder asc
) r