select
	cl.code,
	(select count(*) from cc_classprepare p where p.classlistcode=cl.code and p.org_id=${def:org}) as nowcount,
	
	
	(case when 
				(select 1 from cc_classprepare p where p.classlistcode=cl.code and p.org_id=${def:org} 
					and p.customercode=${fld:customercode}) is null  then '需预约'
			 else '已预约'
	end) as isyuyue,
	
	
	cl.limitcount,
	cl.classdate,
	cd.class_name,
	cd.code as cdcode,
	cm.classroom_name,
	substring(staff.name,0,2) as name,
	cl.status,
	to_char(cl.classtime,'HH24:MI') as classtime,
	
   (select 
		case 
		when 
			to_char({ts '${def:timestamp}'},'yyyy-MM-DD HH24:MI')>to_char(( cl.classdate+cl.classtime::time+ (cd.times||' minutes')::interval),'yyyy-MM-DD HH24:MI')
 		then '已结束'  
		when 
			to_char({ts '${def:timestamp}'},'yyyy-MM-DD HH24:MI')>to_char(( cl.classdate+cl.classtime::time),'yyyy-MM-DD HH24:MI')
			AND
			to_char({ts '${def:timestamp}'},'yyyy-MM-DD HH24:MI')<to_char(( cl.classdate+cl.classtime::time+ (cd.times||' minutes')::interval),'yyyy-MM-DD HH24:MI')
		then '已开始'  
		when  
		to_char({ts '${def:timestamp}'},'yyyy-MM-DD HH24:MI')<to_char(( cl.classdate+cl.classtime::time+ (cd.times||' minutes')::interval),'yyyy-MM-DD HH24:MI')
		then (case when cl.isprepare='1' then '预约中' else
		'开放中' end)
	end from dual) as ss,
	cd.times,
	cl.isprepare
from cc_classlist cl
left join cc_classdef cd on cl.classcode = cd.code and cd.org_id = cl.org_id
left join cc_classroom cm on cm.code = cl.classroomcode and cm.org_id = cl.org_id
left join hr_staff staff on staff.userlogin = cl.teacherid and staff.org_id = cl.org_id
where 1=1
and cl.classdate=${fld:parpreyear}  
and cl.org_id = ${def:org}
and cl.status!=0
and cl.status!=2