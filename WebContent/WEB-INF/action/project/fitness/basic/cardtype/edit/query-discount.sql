select	
	storage,
	discount::NUMERIC(18,2) as discount
from cc_cardtype_storage_discount 
where cardtype= ${fld:id}  and org_id=${def:org}
