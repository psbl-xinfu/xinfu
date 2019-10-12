select
t.created,
(select domain_text_cn from t_domain where "namespace" = 'TrainingSite' and is_enabled = '1' and domain_value=d.train_part) as train_part,
(select domain_text_cn from t_domain where "namespace" = 'LargeCategories' and is_enabled = '1' and domain_value=d.apparatus) as apparatus,
d.actions,
d.train_detail_part,
d.groups,
(select max(weight) from   cc_trainplan_detail_group g where g.detailcode=d.code  and g.org_id=${def:org} and g.status=1) as weight,
(select max(num) from   cc_trainplan_detail_group g where g.detailcode=d.code  and g.org_id=${def:org} and g.status=1) as num,

(select   preparetime from cc_ptprepare pre where pre.code=t.ptpreparecode and  pre.org_id=${def:org} ) as preparetime,
(select   ptdef.ptlevelname  from  cc_ptdef ptdef  where  ptdef.code=t.ptlevelcode and ptdef.org_id=${def:org}  ) as ptlevelname,
(select   s.name from cc_ptprepare pre 
 LEFT JOIN hr_staff s ON pre.ptid=s.userlogin
where pre.code=t.ptpreparecode 
and  pre.org_id=${def:org} ) as name,
d.trainplancode,
t.status,

t.code as tcode,
(select   preparedate from cc_ptprepare pre where pre.code=t.ptpreparecode and  pre.org_id=${def:org} ) as preparedate,
t.customercode,
(select   code from cc_ptprepare pre where pre.code=t.ptpreparecode and  pre.org_id=${def:org} ) as pcode



from cc_trainplan t 
left join cc_trainplan_detail d  on d.trainplancode=t.code and d.org_id=${def:org} and d.status=1
where t.org_id=${def:org}
and t.customercode=${fld:customercode}
and t.status!=0
${filter}
order by t.created desc
