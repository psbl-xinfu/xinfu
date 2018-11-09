select
c.code as ccode,
d.code as classcode,
d.class_name,
d.times,
(select name from hr_staff where userlogin=c.teacherid)as ptname,
  (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE userlogin=c.teacherid
		 )as headpic,
		 d.remark,
classdate,
classtime,
weekday,
classtime::time+ (times||' minutes')::interval as endtime,
c.limitcount,
c.classroomcode,
c.teacherid,
d.classfee,
(select count(1) from cc_classprepare where   classlistcode=c.code and org_id = ${def:org}) as num,
(case when c.status='1' then '正常开课'   when c.status='2' then '未开课'    end) as fabu
from  
cc_classdef d
left join cc_classlist  c  on c.classcode=d.code and c.org_id=d.org_id
where
d.code=${fld:dcode}
and 
c.code=${fld:ccode} and d.org_id = ${def:org}

