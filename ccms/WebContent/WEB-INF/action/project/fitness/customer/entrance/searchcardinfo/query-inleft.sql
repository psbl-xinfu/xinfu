select 
	count(1) as inleftnum
from cc_inleft
where cardcode = ${fld:cardcode} and org_id = ${def:org}
and intime::date >= ('${def:date}'::date - concat((SELECT config.param_value FROM cc_config config WHERE config.category = 'ForeRemind'
and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) ,' day')::interval)::date 
and intime::date<='${def:date}'::date


