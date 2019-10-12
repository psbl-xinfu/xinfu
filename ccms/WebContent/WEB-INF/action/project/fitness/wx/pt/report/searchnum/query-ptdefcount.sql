select 
	count(1) as ptdefcount
from cc_ptlog g
inner join cc_ptdef p on p.code = g.ptlevelcode and g.org_id = p.org_id
where (case when ${fld:type}='0' then g.created::date='${def:date}'::date 
		else to_char(g.created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
	end)
and g.org_id = ${def:org} and p.reatetype !=1 and g.status!=0


