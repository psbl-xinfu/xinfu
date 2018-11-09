select 
	code,
	ptlevelname
from cc_ptdef
where status = 1 and org_id = ${def:org}
