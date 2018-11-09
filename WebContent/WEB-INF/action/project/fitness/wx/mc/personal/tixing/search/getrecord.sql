select
(select  name from cc_guest where  cc_guest.code=guestcode and org_id=${def:org} ) as gname,
(select  name from cc_customer where  cc_customer.code=customercode and org_id=${def:org}) as cname,
(case when status=0 then '无效'    when status=1 then '正常'  
when status=2 then '已确认'    when status=3 then '爽约'   else '已来访' end   )as status,
customercode,
guestcode,
nexttime,
to_char(nexttime+ interval '2 hours', 'HH24:MI:SS') as nexttime1
from
cc_comm
where org_id = ${def:org}
and createdby='${def:user}'
