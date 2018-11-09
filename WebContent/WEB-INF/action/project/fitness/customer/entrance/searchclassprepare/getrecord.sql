select
	cp.code,
	cd.class_name,
	(cl.classdate||' '||to_char(cl.classtime,'HH24:MI')||'~'||to_char((cl.classtime::time+ (cd.times||' minutes')::interval),'HH24:MI')) as classdate,
	(select classroom_name from cc_classroom where code = cl.classroomcode and org_id = ${fld:unionorgid}) as classroom_name,
	(select name from hr_staff where userlogin = cl.teacherid and org_id = ${fld:unionorgid}) as staff_name
from cc_classprepare cp
left join cc_classlist cl on cp.classlistcode = cl.code and cp.org_id = cl.org_id
left join cc_classdef cd on cd.code = cl.classcode and cd.org_id = cl.org_id
left join cc_customer cust on cp.customercode = cust.code and cp.org_id = cust.org_id
where cust.code = ${fld:custall}
and cp.org_id = ${fld:unionorgid} and cp.status = 1