select 
	cabinettempcode
from cc_cabinettemp
where tuid::varchar = (select cabinettempcode from cc_inleft where code = ${fld:code} and org_id = ${def:org})
and org_id = ${fld:org_id}