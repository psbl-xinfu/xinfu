select 
	expercarddef_code as cardtype
	,org_id as unionorgid
from cc_expercard_list
where code = (select cardcode from cc_inleft where code = ${fld:code} and org_id = ${def:org})
and org_id = ${def:org}