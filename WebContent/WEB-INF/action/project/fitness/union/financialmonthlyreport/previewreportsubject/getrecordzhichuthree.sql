select 
	subjectname,
	(select count(1) from cc_report_subject 
		where pid = rs.tuid and org_id = rs.org_id and status=1) as count,
	--判断三级名称是否为空，为空查询二级id
	(case when subjectname is null or subjectname = '' then 
		--判断二级名称是否为空，为空返回pid（一级id）
		(select (case when cs1.subjectname is null or cs1.subjectname='' then 
				cs1.pid else cs1.tuid end) from cc_report_subject cs1
			where cs1.tuid = rs.pid and cs1.org_id = rs.org_id and cs1.status=1)
	else tuid end) as tdid,
	category
from cc_report_subject rs
where rs.grade = 3 and rs.category = 1 and rs.status=1
and rs.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
	UNION 
	SELECT g.org_id FROM hr_org g 
		WHERE EXISTS(SELECT 1 FROM hr_staff_org so WHERE so.userlogin = '${def:user}' AND so.org_id = g.org_id))
order by rs.showorder asc
