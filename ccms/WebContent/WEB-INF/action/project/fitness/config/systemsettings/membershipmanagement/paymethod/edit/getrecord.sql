select
    tuid,
	param_value,
	param_text
from 
	cc_config 
where tuid = ${fld:id}