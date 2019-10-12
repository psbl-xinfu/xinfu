select 
	count(1) as twonum
from 
(select 
	customercode,
	max(enddate) as enddate
from cc_card 
where status in (1,4)--正常、挂失
and isgoon = 0 and org_id = ${def:org}
GROUP BY customercode
) t where enddate<('${def:date}'::timestamp + ('6 month')::interval)
	and enddate>=('${def:date}'::timestamp + ('3 month')::interval)

