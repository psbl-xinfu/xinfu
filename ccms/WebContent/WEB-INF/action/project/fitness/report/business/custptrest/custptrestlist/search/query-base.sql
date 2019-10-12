select 
	pd.ptlevelname,
	pr.pttotalcount::integer,
	pr.ptleftcount::integer,
	pr.ptnormalmoney,
	pr.ptmoney,
	pr.ptfee,
	pr.ptfactfee,
	pr.ptenddate,
	pr.created,
	(select name from hr_staff where userlogin = (
		case when pd.reatetype=1 then (select pt from cc_customer where code=
		pr.customercode and org_id=${def:org}) else pr.ptid
	end)) as ptname,
	(case 
		when pr.pttype=1 then '新买课'
		when pr.pttype=2 then '场地开发'
		when pr.pttype=3 then '续课'
		when pr.pttype=4 then '转课'
		when pr.pttype=5 then '赠课'
	end) as pttype	
from cc_ptrest pr 
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id= pd.org_id
where pr.org_id=${def:org} and pr.customercode = ${fld:code}

${orderby}