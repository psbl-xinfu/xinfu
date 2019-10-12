select
	pr.code,
	pd.ptlevelname,--私教类型
	pr.pttotalcount::int,--私教课总节数
	pr.ptleftcount::int,--私教课剩余节数
	pr.ptnormalmoney,--应收金额
	pr.ptmoney,--实收金额
	pr.ptfee,--原单价
	pr.ptfactfee ,--实收单价
	pr.scale,--提成金额
	(select name from hr_staff where userlogin = pr.ptid and org_id = ${def:org}) as ptname,--私教
	pr.ptenddate,--结束日期
	(case when pr.pttype=1 then '新买课'
	 	when pr.pttype=3 then '续课'
	  	when pr.pttype=4 then '转课' end) as pttype--来源
from cc_ptrest pr
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
where pr.ptenddate::date>='${def:date}'::date
and pr.customercode = ${fld:custcode} and pr.org_id = ${def:org}
and (pr.pttype = 1 or pr.pttype = 3 or pr.pttype = 4)
