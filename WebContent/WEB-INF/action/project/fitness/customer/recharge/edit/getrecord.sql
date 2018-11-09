select
	f.code as f_code,
	cust.code,
	cust.name,
	(case when cust.moneycash<f.factmoney then cust.moneycash else
		(f.factmoney+(select (case when sum(factmoney) is null then 0 else sum(factmoney) end) from cc_chargecard where parentcode = f.code and org_id = ${def:org}))
	end) as factmoney,
	cust.moneycash,
	cust.moneygift,
	(select enddate from cc_card c where c.customercode = cust.code and org_id = ${def:org} order by enddate desc limit 1) as enddate
from cc_chargecard f
left join cc_customer cust on cust.code = f.customercode and cust.org_id = f.org_id
where f.code = ${fld:id} and f.org_id = ${def:org}