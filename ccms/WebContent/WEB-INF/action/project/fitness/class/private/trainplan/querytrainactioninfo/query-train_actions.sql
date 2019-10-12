select 
	train_detail_part
from cc_train_actions
where code = ${fld:code}
and org_id = ${def:org}