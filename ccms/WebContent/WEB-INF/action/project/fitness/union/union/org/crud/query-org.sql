select 
	g.org_id,
	g.org_name 
from hr_org g
where (g.org_id = ${def:org} or g.pid = ${def:org}) 
and g.is_deleted = 0
