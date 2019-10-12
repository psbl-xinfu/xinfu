select 
	pt
from
cc_ptdef_limit
where ptdefcode = ${fld:id} and org_id = ${def:org}
