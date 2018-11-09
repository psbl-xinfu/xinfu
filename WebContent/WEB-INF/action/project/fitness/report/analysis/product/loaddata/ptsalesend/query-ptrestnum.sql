select 
	pd.code,
	pd.ptlevelname,
	count(1) as num
from cc_ptrest rest 
inner join cc_ptdef pd on rest.ptlevelcode = pd.code and rest.org_id = pd.org_id
and pd.reatetype=0 and rest.org_id = ${def:org}
and rest.created::date>=${fld:fdate} and rest.created::date<=${fld:tdate}
GROUP BY pd.code,pd.ptlevelname order by count(1) desc