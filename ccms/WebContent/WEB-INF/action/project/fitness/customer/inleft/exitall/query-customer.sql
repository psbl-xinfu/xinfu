select 
	name
from cc_customer
where code = (select customercode from cc_inleft where code = ${fld:code} and org_id = ${def:org})
and org_id = ${fld:org_id}