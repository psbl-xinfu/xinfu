 and  
 (case
 		when ${fld:s_status}=0 then
 			 exists(
 			 	select 1 from cc_customer  where   to_char(created, 'YYYY-MM') =to_char({ts '${def:timestamp}'}, 'YYYY-MM')
 			 	)
  		    when ${fld:s_status}=1 then
 			not exists(
 			 	select 1 from cc_comm m where m.customercode=c.code  and   to_char(m.created, 'YYYY-MM') =to_char({ts '${def:timestamp}'}, 'YYYY-MM')
 			 	)		
 			 	
 			when ${fld:s_status}=2 then
 			 exists(
 			 	select 1 from cc_customer where birth::int =(select to_char({ts '${def:timestamp}'}, 'MM')::int from dual)
 			 	)		
 			when ${fld:s_status}=3 then
 			 exists(
 			 	select 1 from cc_customer where concat(birth,'-',birthday)  <=to_char({ts '${def:timestamp}'}+'7 day'::interval, 'MM-dd') and concat(birth,'-',birthday)  >=to_char({ts '${def:timestamp}'}, 'MM-dd')
 			 	)	
 end)