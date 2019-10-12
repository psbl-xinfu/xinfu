select 
	(select count(1) from cc_customer) as notinleftnum, 
	sum(case when t.count>0 and t.count<=4 then 1 else 0 end) as onenum,
	sum(case when t.count>4 and t.count<=15 then 1 else 0 end) as twonum,
	sum(case when t.count>15 then 1 else 0 end) as threenum
from
(select 
	customercode,count(1) as count
from cc_inleft
where indate>=${fld:fdate} and indate<=${fld:tdate}
and customercode is not null and customercode !='' and org_id = ${def:org}
GROUP BY customercode
) as t