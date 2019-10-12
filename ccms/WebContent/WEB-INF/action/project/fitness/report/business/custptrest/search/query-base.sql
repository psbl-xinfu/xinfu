select 
	cust.code,
	cust.name,
	cust.mobile,
	sum(case when pr.pttype=5 then ptleftcount else 0 end)::integer as zknum,
	sum(case when pr.pttype=5 then pttotalcount-ptleftcount else 0 end)::integer as completezknum,
	sum(case when pd.reatetype=1 and pr.pttype!=5 then ptleftcount else 0 end)::integer as tynum,
	sum(case when pd.reatetype=1 and pr.pttype!=5 then pttotalcount-ptleftcount else 0 end)::integer as completetynum,
	sum(case when pd.reatetype=0 and pr.pttype!=5 then ptleftcount else 0 end)::integer as sfnum,
	sum(case when pd.reatetype=0 and pr.pttype!=5 then pttotalcount-ptleftcount else 0 end)::integer as completesfnum
from cc_customer cust
left join cc_ptrest pr on pr.customercode = cust.code and pr.org_id = cust.org_id
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id= pd.org_id
where cust.org_id=${def:org} and cust.status = 1 
${filter} 
GROUP BY cust.code,cust.name

${orderby}
