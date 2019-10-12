select 
	'资源' as cust_type,
	g.name,
	(select domain_text_cn from t_domain 
	where "namespace" = 'communicationTarget' and is_enabled = '1' and domain_value = com.commtarget::varchar) as commtarget,
	(case when com.commresult=0 then '免打扰' 
		when com.commresult=1 then '下次通话提醒'
		when com.commresult=2 then '预约到店'
		when com.commresult=3 then '成交' end) as commresult,
	com.nexttime,
	com.reason,
	com.remark,
	(select name from hr_staff where userlogin = com.createdby) as createdby,
	com.created
from cc_comm com
left join cc_guest g on com.guestcode = g.code and com.org_id = g.org_id
where 1=1
and com.org_id = ${def:org}
and com.cust_type=0
${filter} 
${orderby}