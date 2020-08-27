AND 
(case
	when ${fld:shijian}=7 then (case when iit.indate is null 
	then cust.indate else iit.indate end)>(now() -'7 day'::INTERVAL) 
	when ${fld:shijian}=30 then (case when iit.indate is null 
	then cust.indate else iit.indate end)>(now() -'30 day'::INTERVAL) 
	when ${fld:shijian}=3 then (case when iit.indate is null 
	then cust.indate else iit.indate end)>(now() -'3 month'::INTERVAL)
	when ${fld:shijian}=4 then (case when iit.indate is null 
	then cust.indate else iit.indate end)<(now() -'3 month'::INTERVAL)
 end )
