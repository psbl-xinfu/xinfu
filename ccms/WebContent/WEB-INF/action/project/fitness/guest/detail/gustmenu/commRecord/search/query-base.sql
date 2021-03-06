select
	cc_comm.nexttime as shijian,
	cc_comm.remark as vc_remark,
	(case cc_comm.commresult when '0' then '免打扰'
	when '1' then '下次电话提醒'
	when '2' then '预约到店' else '成交' end)as call_result,
	(select name from hr_staff where userlogin=cc_comm.createdby) as vc_iuser,
	cc_comm.created
from  cc_comm
left join cc_customer on cc_comm.customercode=cc_customer.code and cc_customer.org_id = '${def:org}' 
where 1=1 and
(case when ${fld:cust_code} is null then 1=2 else cc_comm.customercode=${fld:cust_code} end)
and cc_comm.org_id = '${def:org}' 

union 

select
	cc_comm.nexttime as shijian,
	cc_comm.remark as vc_remark,
	(case cc_comm.commresult when '0' then '免打扰'
	when '1' then '下次电话提醒'
	when '2' then '预约到店' else '成交' end)as call_result,
	(select name from hr_staff where userlogin=cc_comm.createdby) as vc_iuser,
	cc_comm.created
from  cc_comm
left join cc_guest on cc_comm.guestcode=cc_guest.code and cc_guest.org_id = '${def:org}' 
where 1=1 and
(case when ${fld:guest_code} is null then 1=2 else cc_comm.guestcode=${fld:guest_code} end)
and cc_comm.org_id = '${def:org}' 