select 
	code,
	mobile,
	name,
	sex,
	type
from cc_guest
where code = ${fld:guest_code}
and org_id = ${def:org}