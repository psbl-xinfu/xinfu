(select
count(*)as count,
0 as num
from  cc_comm
where 1=1 
and commresult =1 
and nexttime::date={d '${def:date}'}
and cc_comm.org_id = ${def:org}
and cc_comm.createdby = '${def:user}' )

union

(select
count(*)as count,
1 as num
from  cc_guest_prepare
where 1=1 
and preparedate::date={d '${def:date}'}
and org_id = ${def:org}
and createdby = '${def:user}' 
and status=1)



