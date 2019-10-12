select
	cd.class_name,
	cr.classroom_name,
	(select name from hr_staff where userlogin = cl.teacherid) as name,
	cl.classdate,
	cl.weekday,
	cl.classtime,
	(case when cl.status=1 then '已启用' else '未启用' end)as status,
	cl.limitcount,
	cl.remark,
	to_char((cl.classtime::time+ (cd.times||' minutes')::interval),'HH24:MI') as endtime,
	(cl.limitcount-(select count(1) from cc_classprepare where classlistcode = cl.code and org_id = ${def:org})) as residue,
	(select count(1) from cc_classprepare where classlistcode = cl.code and org_id = ${def:org}) as nowcount,
	cl.personcount,
	(select rules_name from cc_classkq where code=cl.classkqcode) as rules_name
from cc_classlist cl
left join cc_classdef cd on cd.code = cl.classcode and cd.org_id = cl.org_id
left join cc_classroom cr on cl.classroomcode = cr.code and cl.org_id = cr.org_id
where cl.code=${fld:code}
 and cl.org_id = ${def:org}