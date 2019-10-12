select 
	g.created::date as createdate,
	count(1) as num
from cc_ptlog g
inner join cc_ptdef p on p.code = g.ptlevelcode and g.org_id = p.org_id
where to_char(g.created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
and g.org_id = ${def:org} and p.reatetype !=1 and g.status!=0
group by g.created::date order by g.created::date asc

