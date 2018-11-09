SELECT 
	name,
	mobile,
	(case when sex='0' then '男' when sex='1' then '女' end) as sex
from hr_staff
where userlogin = '${def:user}' and org_id = ${def:org}