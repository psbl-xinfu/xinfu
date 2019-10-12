select
preparedate as visitdate,
preparetime as visittime,
(select s.name from hr_staff s where s.userlogin = cc_prepare.createdby) as mc,  
(case cc_prepare.status when '0' then '无效' when '1' then '正常' when '2' then '爽约' else '已来访' end) as status,
(select s.name from hr_staff s where s.userlogin = cc_prepare.createdby) as createdby,
cc_prepare.created,--" IS '操作时间';
cc_prepare.remark as t_remark--" IS '操作类型(0-新增,1-修改)';
from  cc_prepare 
where customercode=${fld:id}
and cc_prepare.org_id = '${def:org}' 
