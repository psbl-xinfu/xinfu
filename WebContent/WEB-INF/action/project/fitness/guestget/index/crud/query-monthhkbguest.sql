select 
	count(1) as monthguestnum
from cc_guest
where to_char(created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
and org_id = ${def:org} and status = 1
and createdby = '${def:user}'