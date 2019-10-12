select 
  distinct code,
  name,
  unit,
  price,
  fastcode
from 
   cc_singleitemdef
where status=1 and org_id =${def:org}