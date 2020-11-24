select
	pr.pttotalcount::int,
	pr.ptleftcount::int,
(select name from hr_staff where userlogin = 
(case when pt.reatetype=1 then cust.pt else pr.ptid end)  ) as name,
	pt.ptlevelname,
	(case
		when pr.pttype=1 then '新买课'
		when pr.pttype=2 then '场地开发'
		when pr.pttype=3 then '续课'
		when pr.pttype=4 then '转课'
		when pr.pttype=5 then '赠课'
		when pr.pttype=6 then '更换'
	end) as pttype,
	(select count(1) from cc_ptlog where ptrestcode = pr.code 
		and customercode = ${fld:custcode} and org_id = ${def:org}) as num
from cc_ptrest pr
left join cc_customer cust on pr.customercode = cust.code and pr.org_id = cust.org_id
left join cc_ptdef pt on pt.code = pr.ptlevelcode and pt.org_id = pr.org_id
where pr.pttype in (1,3,4,5,6) and (pr.ptenddate::date>='${def:date}'::date or pr.ptenddate is null)
and pr.org_id = ${def:org} and pr.customercode = ${fld:custcode}
