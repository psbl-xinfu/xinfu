select 
   org_id AS vc_code,
   name as vc_fullname
from hr_staff 
WHERE org_id = ${def:org}--grade != 1 AND is_closed = '0' AND enabled = '1' 