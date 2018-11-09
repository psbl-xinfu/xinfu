select
	count(1) as num
from cc_site_timelimit
where sitecode=${fld:sitecode} and limittime=to_char(${fld:limittime}::time, 'HH24')::integer
and org_id= ${def:org}
and choose_way = (select prepare_type from cc_siteusedetail where code = ${fld:hccode} and org_id = ${def:org})
and (select count(1) from cc_siteusedetail 
	where sitecode=${fld:sitecode} and status!=0 
	and ${fld:limittime}::time>=prepare_starttime and ${fld:limittime}::time<prepare_endtime
	and prepare_date=(select prepare_date from cc_siteusedetail where code = ${fld:hccode} and org_id = ${def:org})
	and org_id = ${def:org}
	)=0

