select 
	ptlevelname,
	code
from cc_ptdef
where org_id = ${def:org}
