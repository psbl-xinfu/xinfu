select 
	dm.domain_text_cn,
	count(1) as num
from cc_guest guest
left join t_domain dm on guest.demand LIKE concat('%', dm.domain_value, '%')
where guest.status!=0 and guest.demand is not null and guest.demand!=''
and dm."namespace"='demand' and guest.org_id = ${def:org}
and guest.created::date>=${fld:fdate} and guest.created::date<=${fld:tdate}
GROUP BY dm.domain_text_cn order by count(1) desc