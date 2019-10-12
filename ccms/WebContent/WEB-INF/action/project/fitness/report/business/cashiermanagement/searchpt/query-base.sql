select 
	code,
	ptlevelname
from cc_ptdef
where org_id = ${def:org}
