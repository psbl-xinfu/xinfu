select 
   endtime1 as c_endtime1
from 
   cc_cardtype_timelimit
 where 
 	cardtype = ${fld:in_vc_code} and org_id = ${def:org}
 order by
 	weekday