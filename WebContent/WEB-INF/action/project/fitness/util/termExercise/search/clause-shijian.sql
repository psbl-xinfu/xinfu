AND 
(case
	when ${fld:shijian}=7 then (case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)>(now() -'7 day'::INTERVAL) 
	when ${fld:shijian}=30 then (case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)>(now() -'30 day'::INTERVAL) 
	when ${fld:shijian}=3 then (case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)>(now() -'3 month'::INTERVAL)
	when ${fld:shijian}=4 then (case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)<(now() -'3 month'::INTERVAL)
 end )
