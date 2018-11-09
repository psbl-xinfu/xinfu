select 
	created::date as createdate,
	count(1) as num
from cc_guest
where to_char(created::date, 'yyyy-MM') = to_char(${fld:fdate}::date, 'yyyy-MM')
and org_id = ${def:org} and status = 1
and createdby = '${def:user}'
group by created::date