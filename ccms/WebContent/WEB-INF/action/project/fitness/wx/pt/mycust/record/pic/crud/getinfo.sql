select
(select sum(g.weight) from   cc_trainplan_detail_group g 
left join cc_trainplan_detail d  on d.trainplancode=t.code and d.org_id=${def:org} and d.status=1
where g.detailcode=d.code  and g.org_id=${def:org} and g.status=1) as weight,

(select sum(g.num) from   cc_trainplan_detail_group g 
left join cc_trainplan_detail d  on d.trainplancode=t.code and d.status=1
where g.detailcode=d.code  and g.org_id=${def:org} and g.status=1) as num,
t.aerobic_mins,
t.run_mileage,

(
select sum(d.times) from  cc_ptdef d
where  d.code =t.ptlevelcode and d.org_id = ${def:org}
)as times,
(select (${fld:dates}::date - '${fld:day} day'::interval)::date from dual ) as sdate

from cc_trainplan t 
where t.org_id=${def:org}
and t.customercode=${fld:customercode}
and t.status=2
and t.created::date<=${fld:dates}::date
and t.created::date>= (${fld:dates}::date - '${fld:day} day'::interval)::date
