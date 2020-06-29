select	
    code as vc_code,
    proname as vc_name,
    isgood
from 
	cc_product
where 
	code = ${fld:id} 
