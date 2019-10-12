select 
	org.org_id,
	org.org_name
from hr_org org
where (org.org_id=${def:org} or org.pid=${def:org}) and org.is_deleted=0
