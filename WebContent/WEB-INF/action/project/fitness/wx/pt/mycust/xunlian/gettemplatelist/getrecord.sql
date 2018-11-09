select
d.code,
(select domain_text_cn from t_domain where domain_value=d.train_part  and "namespace" = 'TrainingSite')as train_part,
(select domain_text_cn from t_domain where domain_value=d.apparatus and "namespace" = 'LargeCategories')as apparatus,
d.actions,
d.train_detail_part,
p.warmup_mins,
p.aerobic_mins,
p.run_mileage,
(select count(1) from  cc_trainplan_detail_group g where g.detailcode=d.code and  d.org_id=p.org_id)as group,

(select max(num) from  cc_trainplan_detail_group g where g.detailcode=d.code and  d.org_id=p.org_id)as num,

(select max(weight) from  cc_trainplan_detail_group g where g.detailcode=d.code and  d.org_id=p.org_id)as weight,

d.train_part as actioncode1,
d.apparatus  as actioncode2,
d.actionscode  as actioncode3,
d.created,
p.status
from    
cc_trainplan_detail  d
left join cc_trainplan p on p.code=d.trainplancode and p.org_id=${def:org}
where
 d.trainplancode=${fld:traincode} and d.org_id=${def:org}
 order by d.code


