select 
	(case when t.msnum is null then 0 else t.msnum end) as msnum,
	(case when t.yynum is null then 0 else t.yynum end) as yynum
from 
(select 
	sum(case when gv.preparecode is null or gv.preparecode = '' then 1 else 0 end) as msnum,
	sum(case when gv.preparecode is not null then 1 else 0 end) as yynum
from cc_guest_visit gv
where gv.org_id = ${def:org}
and gv.visitdate::date >= ${fld:fdate} AND gv.visitdate::date <= ${fld:tdate}
and gv.status!=0
) as t

