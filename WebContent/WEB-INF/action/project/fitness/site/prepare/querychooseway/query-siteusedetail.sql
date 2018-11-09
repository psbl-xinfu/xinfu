select 
	count(1) as sdnum
from cc_siteusedetail
where sitecode=${fld:sitecode} and status>0 and org_id = ${def:org}
and prepare_date = ${fld:prepare_date}::date 
and ${fld:times}::time>=prepare_starttime and ${fld:times}::time<prepare_endtime  

