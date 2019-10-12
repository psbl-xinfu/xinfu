select 
	customercode,
	cardcode,
	cabinettempcode as inlefttempcode
from cc_inleft 
where code = ${fld:code} and org_id = ${def:org}
