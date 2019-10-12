select
	cust.name,
	cust.mobile,
	p.ptlevelname,
	pd.delayday,
	pd.ptenddate,
	pd.remark,
	(pd.ptenddate::date-pd.delayday::integer) as yqqdate
from cc_ptrest_delay pd
left join cc_ptrest pr on pd.ptrestcode = pr.code and pd.org_id = pr.org_id
left join cc_customer cust on pr.customercode = cust.code and pr.org_id = cust.org_id
left join cc_ptdef p on p.code = pr.ptlevelcode and p.org_id = pr.org_id
where pd.org_id = ${def:org} and pd.code = ${fld:code}
