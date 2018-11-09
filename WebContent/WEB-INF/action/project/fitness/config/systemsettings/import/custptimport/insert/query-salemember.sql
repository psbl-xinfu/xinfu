select 
	staff.name
from hr_staff staff
where staff.org_id = ${def:org}
