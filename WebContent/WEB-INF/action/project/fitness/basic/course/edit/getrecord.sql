select	
    code as vc_code,
    courname as vc_name,
    isgood
from 
	cc_course
where 
	code = ${fld:id} 
