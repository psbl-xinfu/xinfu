select 
  distinct code as codebin,
  name as singnamebin,
  unit as unitbin,
  price as pricebin,
  fastcode as fastcodebin
from 
   cc_singleitemdef
where status=1 and org_id =${def:org}