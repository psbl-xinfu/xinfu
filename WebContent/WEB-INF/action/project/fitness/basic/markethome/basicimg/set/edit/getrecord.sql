select	
attachid,
linkurl
from 
	hr_org_banner
where 
	bannertype = ${fld:bannertype}
and 
	org_id=${def:org}
order by tuid desc limit 1
