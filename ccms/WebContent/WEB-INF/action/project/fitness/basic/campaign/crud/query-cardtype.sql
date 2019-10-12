select 
   code as vc_code,
   name as vc_name
from 
   cc_cardtype
   where status=1 and org_id = ${def:org}