select 
p.detailcode,
p.groups,
p.weight,
p.num,
p.custfeel,
d.code,
p.code as pcode,
p.weight,
p.num,
p.custfeel
from    
cc_trainplan_detail  d
left join cc_trainplan_detail_group p on  p.detailcode=d.code and  d.org_id=p.org_id
where
 d.trainplancode=${fld:traincode} and d.org_id=${def:org}
 order by p.code


