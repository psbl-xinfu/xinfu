select
visitdate,
visittime,
(select s.name from hr_staff s where s.userlogin = cc_guest_visit.mc) as mc,  
(case cc_guest_visit.status when '0' then '无效' when '1' then '正常' when '2' then '未成交' else '已成交' end) as status,

(select s.name from hr_staff s where s.userlogin = cc_guest_visit.createdby) as createdby,
cc_guest_visit.created,--" IS '操作时间';
cc_guest_visit.remark as t_remark--" IS '操作类型(0-新增,1-修改)';
from  cc_guest_visit 
left join cc_guest g on cc_guest_visit.guestcode=g.code and g.org_id = '${def:org}' 
where guestcode=${fld:id}
and cc_guest_visit.org_id = '${def:org}' 
