select 
	cardtype
	,org_id as unionorgid
from cc_card
where code = (select cardcode from cc_inleft where code = ${fld:code} and org_id = ${def:org})
and org_id = ${fld:org_id}