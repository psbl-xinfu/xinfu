select 
	rs.tuid,
	rs.subjectname as foursubjectname,
	(case when subjectname is null or subjectname = '' then 
		--判断三级名称是否为空，为空查询二级id
		(select (case when cs1.subjectname is null or cs1.subjectname='' then 
				--判断二级名称是否为空，为空返回pid（一级id）
				(select (case when cs2.subjectname is null or cs2.subjectname='' then 
						cs2.pid else cs2.tuid end) from cc_report_subject cs2 
				where cs2.tuid = cs1.pid and cs2.org_id = ${def:org} and cs2.status=1)
			else cs1.tuid end) from cc_report_subject cs1
			where cs1.tuid = rs.pid and cs1.org_id = ${def:org} and cs1.status=1)
	else tuid end) as tdid,
	--三级目录
	(select rs3.subjectname from cc_report_subject rs3 
		where rs3.tuid = rs.pid and rs3.org_id = rs.org_id) as threesubjectname,
	--二级目录
	(select rs2.subjectname from cc_report_subject rs2 where rs2.tuid = 
		(select rs3.pid from cc_report_subject rs3 where rs3.tuid = rs.pid and rs3.org_id = rs.org_id)
	and rs2.org_id = rs.org_id) as twosubjectname,
	--一级目录
	(select rs1.subjectname from cc_report_subject rs1 where rs1.tuid = 
		(select rs2.pid from cc_report_subject rs2 where rs2.tuid = 
			(select rs3.pid from cc_report_subject rs3 where rs3.tuid = rs.pid and rs3.org_id = rs.org_id)
		and rs2.org_id = rs.org_id)
	and rs1.org_id = rs.org_id) as onesubjectname
from cc_report_subject rs
where 1=1
and rs.org_id = ${def:org} and rs.status = 1 
and rs.grade = (select max(grade) as grade from cc_report_subject where org_id = ${def:org} and status = 1)
and category=1
order by rs.showorder asc
	
