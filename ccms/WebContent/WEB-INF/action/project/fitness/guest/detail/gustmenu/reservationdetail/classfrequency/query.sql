select 
	created::date as createdate,
	count(1) as num
from cc_ptlog
where customercode = ${fld:custcode} and status = 1 and org_id = ${def:org}
and created::date>${fld:fdate} and created::date<=${fld:tdate}
GROUP BY created::date order by created::date asc


