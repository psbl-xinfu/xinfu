select 
	count(1) as num
from cc_siteusedetail
where sitecode=${fld:sitecode} and status>0 and org_id = ${def:org}
and prepare_date = ${fld:prepare_date}::date and prepare_type = ${fld:prepare_type}
and ${fld:limittime}::time>=prepare_starttime and ${fld:limittime}::time<prepare_endtime  

