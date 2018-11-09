select
name,
  (select comm.created from  cc_comm comm
   where comm.operatortype=0 and comm.customercode=cc_customer.code
    and comm.createdby='${def:user}' and org_id = ${def:org}
   order by comm.created desc 
  limit 1 ) as lasttime,
   (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE userlogin=(select userlogin from hr_staff where user_id=cc_customer.user_id )
		 )as headpic
from 
cc_customer 
where 
code=${fld:recuser}
and org_id=${def:org} 