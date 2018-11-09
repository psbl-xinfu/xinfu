select 
	count(1) as num
from cc_ptlog pl
inner join cc_ptrest pr on pl.ptrestcode = pr.code and pl.org_id = pr.org_id
where pr.pttype in (1,3,4,5) and pr.ptenddate::date>='${def:date}'::date
and pl.org_id = ${def:org} and pr.customercode = ${fld:custcode}
and pl.status=1