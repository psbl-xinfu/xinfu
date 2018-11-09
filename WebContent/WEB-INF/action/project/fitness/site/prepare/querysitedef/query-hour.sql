select 
	MIN(opening_date) as minhour,
	MAX(closed_date) as maxhour
from cc_sitedef
where status = 1 and org_id = ${def:org} 
and (case when ${fld:sitetype} is null then 1=1 else sitetype = ${fld:sitetype} end)