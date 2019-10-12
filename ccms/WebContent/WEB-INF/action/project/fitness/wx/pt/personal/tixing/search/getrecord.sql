select
(case when
	(
	SELECT 1 FROM cc_ptrest t 
		WHERE t.customercode = cc_comm.customercode AND t.ptleftcount > 0 AND t.pttype != 5  AND t.ptid='${def:user}' limit 1
	) is not null  then 1
	else 0
end)as custype,
(case when status=0 then '无效'    when status=1 then '正常'  
when status=2 then '已确认'    when status=3 then '爽约'   else '已来访' end   )as status,
nexttime,

(select name  from  cc_customer where code=cc_comm.customercode)as cname,
customercode,
to_char(nexttime+ interval '2 hours', 'HH24:MI:SS') as nexttime1
from
cc_comm
where createdby='${def:user}' and  org_id=${def:org} and status=1 and commresult=1
and nexttime::date=${fld:s_date}