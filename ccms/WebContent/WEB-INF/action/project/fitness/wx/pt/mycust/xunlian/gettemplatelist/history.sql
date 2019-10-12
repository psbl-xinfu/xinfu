select
d.train_part,
d.apparatus,
d.actionscode,
d.trainplancode,
(select count(1) from  cc_trainplan_detail_group g where g.detailcode=d.code and  d.org_id=g.org_id)as group,
(select max(num) from  cc_trainplan_detail_group g where g.detailcode=d.code and  d.org_id=g.org_id)as num,
(select max(weight) from  cc_trainplan_detail_group g where g.detailcode=d.code and  d.org_id=g.org_id)as weight,
d.created
from 
cc_trainplan_detail d
where 
d.trainplancode=(
SELECT
	t.code
 FROM cc_trainplan t
where  t.customercode=${fld:custcode} and t.ptlevelcode =${fld:pdcode} and  t.created::date<${fld:datetimepicker}::date and t.org_id=${def:org}
and t.status=2
order by t.code desc limit 1 )
and d.org_id=${def:org}