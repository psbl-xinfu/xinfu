select 
	orderfee_target
from cc_target_group
where target_type = 0 and org_id = ${def:org}
and pk_value = (select skill_id from hr_skill where skill_name = '会籍顾问' and org_id=${def:org} limit 1) and to_char(concat(target_year, '-', target_month, '-01')::date, 'yyyy-MM')=
	to_char('${def:date}'::date, 'yyyy-MM')
limit 1

	
