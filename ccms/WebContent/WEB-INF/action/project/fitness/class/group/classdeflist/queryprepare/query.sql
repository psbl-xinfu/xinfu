select
	cl.code,
	(select count(1) from cc_classprepare where classlistcode = cl.code and org_id = ${def:org}) as nowcount,
	cl.limitcount,
	cl.classdate,
	cd.class_name,
	cd.code as cdcode,
	cm.classroom_name,
	staff.name,
	cl.status,
	to_char(cl.classtime,'HH24:MI') as classtime,
	to_char((cl.classtime::time+ (cd.times||' minutes')::interval),'HH24:MI') as endtime,
	cd.class_bgcolor
from cc_classlist cl
left join cc_classdef cd on cl.classcode = cd.code and cd.org_id = cl.org_id
left join cc_classroom cm on cm.code = cl.classroomcode and cm.org_id = cl.org_id
left join hr_staff staff on staff.userlogin = cl.teacherid
where 1=1
and (cl.classdate>=${fld:startdate} and cl.classdate<=${fld:enddate}) 
and (case when ${fld:classcode} is null then 1=1 else cl.classcode = ${fld:classcode} end)
and (case when ${fld:classroomcode} is null then 1=1 else cl.classroomcode = ${fld:classroomcode} end)
and (case when ${fld:teacherid} is null then 1=1 else cl.teacherid = ${fld:teacherid} end)
and cl.org_id = ${def:org}
and cl.status!=0
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else cl.teacherid = '${def:user}' end)