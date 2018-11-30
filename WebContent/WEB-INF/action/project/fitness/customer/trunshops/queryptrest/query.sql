select
	pr.code as prid,
	pr.contractcode,
	pr.ptlevelcode,
	pr.ptid,
	pr.org_id,
	pd.ptlevelname,--私教类型
	pr.pttotalcount::int,--私教课总节数
	pr.ptleftcount::int,--私教课剩余节数
	(select name from hr_staff where userlogin = pr.ptid and org_id = ${def:org}) as ptname,--私教
	pr.ptenddate,--结束日期
	(case when pr.pttype=1 then '新买课'
	 	when pr.pttype=3 then '续课'
	  	when pr.pttype=4 then '转课' end) as pttype--来源
from cc_ptrest pr
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
where  pr.customercode = ${fld:custcode} and pr.org_id = ${def:org}



