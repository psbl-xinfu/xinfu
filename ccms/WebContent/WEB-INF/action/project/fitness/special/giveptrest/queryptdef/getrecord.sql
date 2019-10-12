SELECT 
	distinct pd.code,
	pd.ptlevelname,
	pd.ptfee
FROM cc_ptdef pd
left join cc_ptdef_limit pl on pd.code= pl.ptdefcode and pd.org_id = pl.org_id
where pd.org_id = ${def:org}
and pl.pt = ${fld:pt}
and (case when (select distinct pt from cc_customer where code=${fld:cust} and org_id=${def:org})!=pl.pt then pd.reatetype=0
when (select distinct pt from cc_customer where code=${fld:cust} and org_id=${def:org})=pl.pt then 1=1  else
1=1
 end)
