select 
	tg.guest_target as guest_target
from cc_target_group tg
where to_char(concat(tg.target_year, '-', tg.target_month, '-01')::date, 'yyyy-MM') 
	= to_char(${fld:daydateinfo}::date, 'yyyy-MM')
and tg.org_id = ${def:org} and tg.target_type = 1 and pk_value = ${fld:pk_value}