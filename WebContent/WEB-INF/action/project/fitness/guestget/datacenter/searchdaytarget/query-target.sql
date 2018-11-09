select 
	sum(tg.guest_target) as guest_target
from cc_target_group tg 
where to_char(concat(tg.target_year, '-', tg.target_month, '-01')::date, 'yyyy-MM') 
	= to_char(${fld:daydateinfo}::date, 'yyyy-MM')
and tg.org_id = ${def:org} and tg.target_type = 1 
and (case when ${fld:team_id} is null then 1=1 else pk_value = ${fld:team_id} end)