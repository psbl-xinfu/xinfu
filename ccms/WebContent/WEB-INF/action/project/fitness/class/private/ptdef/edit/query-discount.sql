select 
	startcount,
	endcount,
	reate
from 
cc_ptdef_discount
where ptdefcode = ${fld:id} and org_id = ${def:org}