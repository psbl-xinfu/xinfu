select 
   starttime1 as c_starttime1
from 
   cc_cardtype_timelimit
 where 
 	cardtype = ${fld:in_vc_code} and org_id = ${def:org}
 order by
 	weekday