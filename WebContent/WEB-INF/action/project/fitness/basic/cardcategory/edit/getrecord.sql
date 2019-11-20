select	
    code as vc_code,
    posname as vc_name
from 
	cc_position
where 
	code = ${fld:id} 
