select
    (case when com.cust_type=0 then '资源'
	      when com.cust_type=1 then '会员'
	      when com.cust_type=2 then '私教' end
	) as cust_type,
	g.name,
	(select domain_text_cn from t_domain 
	where "namespace" = 'communicationTarget' and is_enabled = '1' and domain_value = com.commtarget::varchar) as commtarget,
	(case when com.commresult=0 then '免打扰' 
		when com.commresult=1 then '预约通话'
		when com.commresult=2 then '预约到店'
		when com.commresult=3 then '成交' end) as commresult,
	com.nexttime,
	com.reason,
	com.remark,
	(select domain_text_cn from t_domain where "namespace" = 'CommStage' and t_domain.domain_value= com.stage)as commstage,	--沟通阶段

	(select name from hr_staff where userlogin = com.createdby and hr_staff.org_id = ${def:org}) as createdby,
	com.created
from cc_comm com
left join cc_guest g on com.guestcode = g.code and com.org_id = g.org_id
where 1=1
and com.org_id = ${def:org}
and com.cust_type=0
${filter} 
${orderby}