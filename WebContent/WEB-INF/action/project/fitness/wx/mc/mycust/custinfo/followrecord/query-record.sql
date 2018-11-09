select
	cc_comm.nexttime as shijian,
	cc_comm.remark as vc_remark,
	(case cc_comm.commresult when '0' then '免打扰'
	when '1' then '下次电话提醒'
	when '2' then '预约到店' else '成交' end)as call_result,
	(select name from hr_staff where userlogin=cc_comm.createdby) as vc_iuser
from  cc_comm
left join cc_customer on cc_comm.customercode=cc_customer.code and cc_customer.org_id = ${def:org}
where 1=1 and
(case when ${fld:customercode} is null then 1=2 else cc_comm.customercode=${fld:customercode} end)
and cc_comm.org_id = ${def:org}
and 
 (
	CASE WHEN (SELECT hs.data_limit FROM hr_staff hs WHERE hs.userlogin = '${def:user}'   and org_id = ${def:org} LIMIT 1) = 1 
	THEN true ELSE cc_comm.createdby = '${def:user}' END
) 

and cc_comm.org_id=${def:org}