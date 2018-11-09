select 
	code,
	actions
from cc_train_actions
where train_part = ${fld:trainingsite} and apparatus = ${fld:largecategories}
and org_id = ${def:org}