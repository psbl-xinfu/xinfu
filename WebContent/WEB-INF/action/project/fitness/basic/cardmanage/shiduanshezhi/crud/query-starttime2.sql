select 
   starttime2 as c_starttime2
from 
   cc_cardtype_timelimit
 where 
 	cardtype = ${fld:in_vc_code} and org_id = ${def:org}
 order by
 	weekday