select 
	count(1) as guestnum
from cc_comm comm
where (case when ${fld:type}='0' then comm.created::date='${def:date}'::date 
	else to_char(comm.created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
	end)
and comm.operatortype = 1 and comm.org_id = ${def:org} and comm.status!=0

