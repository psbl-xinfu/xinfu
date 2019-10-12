select
class_name,
arrivetime,
(case when cc_classprepare.status='0' then '无效' when cc_classprepare.status='1' then '预约中' 
		  when cc_classprepare.status='2' then '已上课'  else '爽约' end) as status,
(select name from hr_staff where userlogin=cc_classprepare.createdby) as vc_iuser,
cc_classprepare.created
from
cc_classprepare
left join cc_classlist on cc_classlist.code = cc_classprepare.classlistcode and cc_classlist.org_id='${def:org}' 
left join cc_classdef on cc_classdef.code = cc_classlist.classcode and cc_classdef.org_id='${def:org}' 
where 
customercode=${fld:id} and cc_classprepare.org_id='${def:org}' 

