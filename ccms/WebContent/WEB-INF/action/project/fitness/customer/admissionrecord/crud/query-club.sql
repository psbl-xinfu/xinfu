select 
   vc_code,
   vc_fullname
from 
   e_clubdef
where vc_club = '${def:org}'