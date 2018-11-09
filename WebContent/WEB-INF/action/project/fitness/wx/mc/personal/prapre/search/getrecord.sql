select 
code as commcode,
guestcode as code,
(select name from cc_guest where code=guestcode and org_id = ${def:org} order by created desc limit 1 )as name,
(case when status=0 then '无效'    when status=1 then '预约中'  
when status=2 then '已确认'    when status=3 then '爽约'   when status=4 then '已来访' else '取消' end   )as status,
preparetime,
to_char(preparetime+ interval '2 hours', 'HH24:MI:SS') as preparetime1
from
cc_guest_prepare
where 
preparedate=${fld:s_date}
and createdby='${def:user}'
and org_id=${def:org}
and status!=0	
