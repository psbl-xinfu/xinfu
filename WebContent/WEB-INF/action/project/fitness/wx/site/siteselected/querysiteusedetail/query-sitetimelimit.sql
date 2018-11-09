select (case when (select 
	choose_way
from cc_site_timelimit
where sitecode=${fld:sitecode} and limittime=${fld:time}
and org_id= ${fld:org_id} limit 1) is null then null else (select 
	choose_way
from cc_site_timelimit
where sitecode=${fld:sitecode} and limittime=${fld:time}
and org_id= ${fld:org_id} limit 1) end) as choose_way from dual;



