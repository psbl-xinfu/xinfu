select 
	1
from cc_siteusedetail
where sitecode=${fld:site_timelimitcode} and status>0 and org_id = ${def:org}
and (select concat(limittime, ':00:00') from cc_site_timelimit where code = ${fld:site_timelimitcode})::time>=prepare_starttime 
and (select concat(limittime, ':00:00') from cc_site_timelimit where code = ${fld:site_timelimitcode})::time<prepare_endtime  

