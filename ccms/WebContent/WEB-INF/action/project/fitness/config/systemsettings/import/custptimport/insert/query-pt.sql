select 
	staff.name as pt
from hr_staff staff
where staff.org_id = ${def:org}
