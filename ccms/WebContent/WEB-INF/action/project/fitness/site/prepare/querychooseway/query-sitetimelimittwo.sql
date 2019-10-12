select (case when (select 
	code
from cc_site_timelimit
where sitecode=${fld:sitecode} and limittime=${fld:limittime}
and org_id= ${def:org} limit 1) is null then null else (select 
	code
from cc_site_timelimit
where sitecode=${fld:sitecode} and limittime=${fld:limittime}
and org_id= ${def:org} limit 1) end) as code from dual;

