select 
	MIN(opening_date) as minhour,
	MAX(closed_date) as maxhour
from cc_sitedef
where status = 1 and org_id = ${fld:org_id} and sitetype = ${fld:sitetype}