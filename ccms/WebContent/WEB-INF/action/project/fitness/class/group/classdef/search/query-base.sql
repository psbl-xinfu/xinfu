select
	code,
	concat('<input type="checkbox" name="classlist" code="', status, '" value="', code, '" "/>') AS checklink,
	class_name,
	class_ename,
	times,
	(select classroom_name from cc_classroom where code = classroomcode and cc_classroom.org_id = ${def:org}) as classroomcode,
	(case when isprepare=1 then '是' else '否' end) as isprepare,
	classfee,
	(case status when 1 then '已启用' when 0 then '已禁用' else '' end) status,
	classinfo,
	remark
from cc_classdef
where 1=1 and org_id = ${def:org}
${filter}
${orderby}


