select
d.code,
d.train_part,
d.apparatus,
(select 
	code
from cc_train_actions
where train_part = d.train_part and apparatus = d.apparatus and actions=d.actions
and org_id = ${def:org})as actions,

d.train_detail_part,
d.groups
from    
cc_trainplan_detail  d
where
 d.code=${fld:code} and d.org_id=${def:org}
 order by d.code


