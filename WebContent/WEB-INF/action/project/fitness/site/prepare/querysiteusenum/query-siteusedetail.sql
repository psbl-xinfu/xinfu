select 
	count(1) as num
from cc_siteusedetail
where sitecode=${fld:sitecode} and status>0 and org_id = ${def:org}
and prepare_date = ${fld:prepare_date}::date
and ((${fld:starttime}::time>=prepare_starttime and ${fld:starttime}::time<prepare_endtime) 
or (${fld:endtime}::time>prepare_starttime and ${fld:endtime}::time<=prepare_endtime )) 

