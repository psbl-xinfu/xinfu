 --关注度
and (case when ${fld:s_level} is null then 1=1 
 		    else 
 			 exists(
 			 	select 1 from cc_comm m  where  m.customercode=c.code and m.level=${fld:s_level} and m.org_id=${def:org} 
 			 	and cust_type=2
 			 	order by created desc limit 1
 			 	)
		end)