update cc_customer set 
	moneygift = (case when moneygift is null then 
		(0+${fld:moneygift}) else (moneygift+${fld:moneygift}) end),
	moneycash = (case when moneycash is null then 
		(0+${fld:moneycash}+${fld:moneygift}) else (moneycash+${fld:moneycash}+${fld:moneygift}) end)
where code=${fld:cust_code} and org_id = ${def:org}
