select	
    code,
    ptlevelname,
    ptfee,
    reatetype,
    ptfee,
    scale,
    status,
    is_delay,
    remark,
    times,
    spacing,
    isgroup
from 
	cc_ptdef
where 
	code = ${fld:id} and org_id = ${def:org}
