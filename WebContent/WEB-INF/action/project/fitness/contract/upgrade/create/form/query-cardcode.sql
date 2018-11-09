select 
	get_arr_value(relatedetail,1) as card_code
from cc_contract 
where code = ${fld:contractcode} 
and org_id = ${def:org}