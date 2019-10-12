AND 
(case
	when ${fld:shijian}=7 then (select max(created) from cc_ptlog where customercode=cust.code and org_id = cust.org_id limit 1)>(now() -'7 day'::INTERVAL) 
	when ${fld:shijian}=30 then (select max(created) from cc_ptlog where customercode=cust.code and org_id = cust.org_id limit 1)>(now() -'30 day'::INTERVAL) 
	when ${fld:shijian}=3 then (select max(created) from cc_ptlog where customercode=cust.code and org_id = cust.org_id limit 1)>(now() -'3 month'::INTERVAL)
	when ${fld:shijian}=4 then (select max(created) from cc_ptlog where customercode=cust.code and org_id = cust.org_id limit 1)<(now() -'3 month'::INTERVAL)
 end )
