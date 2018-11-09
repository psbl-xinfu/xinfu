select 
	COUNT(1) AS tiyancount 
from cc_ptlog p 
inner join cc_ptdef d on d.code = p.ptlevelcode and p.org_id = d.org_id
where p.status != 0 and p.org_id = ${def:org} and d.reatetype = 1
and (case when ${fld:type}='0' then p.created::date='${def:date}'::date 
		else to_char(p.created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')end)