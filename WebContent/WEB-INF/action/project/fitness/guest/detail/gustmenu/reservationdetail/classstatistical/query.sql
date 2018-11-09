select 
	sum(pttotalcount)::int as pttotalcount,
	sum(ptleftcount)::int as ptleftcount
from cc_ptrest
where pttype in (1,3,4,5) and ptenddate::date>='${def:date}'::date
and org_id = ${def:org} and customercode = ${fld:custcode}
