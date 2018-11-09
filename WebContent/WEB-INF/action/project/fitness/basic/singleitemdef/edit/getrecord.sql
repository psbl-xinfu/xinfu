select
	code,
    fastcode,
    name,
    type,
    unit,
    price,
    remark,
    status as statustype,
    isliliao,
    commission,
    type,
    unit,
    status
from cc_singleitemdef
where 
	code = ${fld:id} and org_id = ${def:org}
