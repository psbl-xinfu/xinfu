select
		cc_guest_prepare.preparedate::date as shijian,
		to_char(cc_guest_prepare.preparetime, 'HH24:MI:SS') as stime,
		to_char(cc_guest_prepare.preparetime+ interval '2 hours', 'HH24:MI:SS') as etime,
	(
	select t.domain_text_cn from t_domain t 
	where t.namespace = 'communicationTarget' 
	 and is_enabled = '1' and domain_value not in ('8', '9')
	and t.domain_value = cast(cc_comm.commtarget as char) 
) as commtarget,
	
	(case cc_guest_prepare.status when '0' then '无效'
	when '1' then '预约中'
	when '2' then '已确认'
	when '3' then '爽约'
	else '已来访' end)as pre_result
from  cc_guest_prepare
left join  cc_comm on  cc_guest_prepare.code=cc_comm.preparecode and cc_comm.org_id=${def:org}
where 
 cc_guest_prepare.org_id = ${def:org}
and cc_guest_prepare.code=${fld:commcode}
and cc_guest_prepare.createdby = '${def:user}' 
