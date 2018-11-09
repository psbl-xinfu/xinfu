select	
attachid,
linkurl
from 
	hr_org_banner
where 
	campaigntype = 1
and 
	org_id=${def:org}
order by tuid desc limit 1
