(select
	g.mobile,
	g.name,
	g.code,
	(select comm.created from  cc_comm comm
       where  comm.operatortype=0  and cust_type=0   and comm.guestcode=g.code and comm.createdby='${def:user}'
       and comm.org_id = ${def:org} order by comm.created desc limit 1 ) as lasttime
from cc_guest g 
left join (select guestcode,name,mobile,position,sex from cc_thecontact where 
 status=1  and org_id=${def:org} ) as tt on tt.guestcode=g.code 

WHERE 
g.mc='${def:user}'

and
 	g.org_id = ${def:org}
 	${filter}
  )
 
order by num,code desc