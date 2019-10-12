SELECT 
	name,
	mobile,
	(case when sex='0' then 'icon-man' when sex='1' then 'icon-woman' else '' end) as sexclass
from hr_staff
where userlogin = '${def:user}' and org_id = ${def:org}