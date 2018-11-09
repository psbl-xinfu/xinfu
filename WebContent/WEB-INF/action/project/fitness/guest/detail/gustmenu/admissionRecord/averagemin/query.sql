select 
	indate as createdate,
	((to_char((sum((case when lefttime is null then concat(indate, ' 23:59:59')::timestamp 
		else lefttime end)-intime)), 'HH24')::int*60)+to_char((sum((case when lefttime is null then concat(indate, ' 23:59:59')::timestamp 
		else lefttime end)-intime)), 'mi')::int)/count(1) as num
from cc_inleft
where itemtype = 0 and customercode = ${fld:custcode}
and org_id = ${def:org}
and indate>${fld:fdate} and indate<=${fld:tdate}
and lefttime is not null
GROUP BY indate order by indate asc
