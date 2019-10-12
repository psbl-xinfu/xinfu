select 
	code
from cc_site_timelimit
where sitecode=${fld:sitecode} and limittime=${fld:limittime}
and org_id= ${def:org}

