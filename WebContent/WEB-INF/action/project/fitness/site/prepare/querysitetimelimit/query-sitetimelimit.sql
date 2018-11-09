select 
	count(1) as num
from cc_site_timelimit
where sitecode=${fld:sitecode} and limittime=${fld:limittime}
and org_id= ${def:org}
and (case when ${fld:choose_way} is null then 1=1 else choose_way = ${fld:choose_way} end)

