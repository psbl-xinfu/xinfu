select 
	ts.guest_target
from cc_target_staff ts
left join cc_target_group tg on ts.targetgroupid = tg.tuid and ts.org_id = tg.org_id
where to_char(concat(tg.target_year, '-', tg.target_month, '-01')::date, 'yyyy-MM') 
	= to_char(${fld:daydateinfo}::date, 'yyyy-MM')
and tg.org_id = ${def:org} and tg.target_type = 1 and ts.userlogin = '${def:user}'