select  distinct
   code as vc_code, 
   category_name as vc_name
from 
   cc_cardcategory
where org_id = ${def:org}
   
 