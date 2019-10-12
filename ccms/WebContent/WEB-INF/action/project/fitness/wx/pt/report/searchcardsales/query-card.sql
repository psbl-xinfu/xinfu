select
	rest.created::date as createdate,
	count(1) as num,
	sum(ptmoney) as factmoney
from cc_ptrest rest 
inner join cc_ptdef pd on rest.ptlevelcode = pd.code and rest.org_id = pd.org_id
and pd.reatetype=0 and rest.org_id = ${def:org}
and to_char(rest.created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
GROUP BY rest.created::date order by rest.created::date asc
