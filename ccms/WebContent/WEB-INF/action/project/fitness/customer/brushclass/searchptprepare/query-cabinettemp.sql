select
	string_agg(cabinettempcode, ',') as cabinettempcode
from cc_cabinettemp
where status=1 and customercode = ${fld:customercode}
and org_id = ${def:org}