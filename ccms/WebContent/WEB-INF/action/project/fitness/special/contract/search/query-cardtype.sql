select t.name as vc_name
from cc_cardtype t 
where code = (
	select cardtype from cc_card 
	where code = ${fld:vc_code} and org_id = ${def:org} and isgoon = 0 limit 1
) and org_id =${def:org}