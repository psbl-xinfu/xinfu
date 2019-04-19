select cust.name,(case WHEN cust.sex = '0' then '女' when cust.sex = '1' then '男' else '未知' end) as sex,
cust.mobile,(SELECT hr_staff.name from hr_staff where hr_staff.user_id=cust.user_id) as pt,
 (select max(created) from cc_ptlog where customercode=cust.code and org_id = cust.org_id limit 1) as created,
(NOW()::date - (select max(created) from cc_ptlog where customercode=cust.code and org_id = cust.org_id limit 1)::date) as tians																--最后锻炼时间

from cc_customer cust 
where 

  EXISTS(
	select 1 from cc_ptlog log
	where log.customercode = cust.code and
	(case when ${fld:shijian} is null then
	log.created>(now() -'30 day'::INTERVAL) 
	else 1=1 ${filter}
	end) 
)

and cust.org_id=${def:org}  and
(case when ${fld:pt} is null then 1=1 else cust.pt = ${fld:pt} end)
and
(case when ${fld:pt} is null then 1=1 else cust.pt = ${fld:pt} end)
	and
	(case when ${fld:shijian} is null then
	(select max(created) from cc_ptlog where customercode=cust.code and org_id = cust.org_id limit 1)>(now() -'30 day'::INTERVAL) 
	else 1=1 ${filter}
	end) 
order by tians