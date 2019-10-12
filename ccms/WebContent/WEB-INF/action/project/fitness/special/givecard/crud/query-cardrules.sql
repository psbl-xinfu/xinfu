SELECT 
tuid,
param_text 
from cc_config
WHERE category='PresentReason' 
and org_id = ${def:org}
   
 