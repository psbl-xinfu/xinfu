select 
  distinct code,
  name
from 
   cc_singleitemdef
where status=1 and org_id =${def:org}