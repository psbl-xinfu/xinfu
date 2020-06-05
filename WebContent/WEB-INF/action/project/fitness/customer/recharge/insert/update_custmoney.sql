update cc_customer set 
	moneygift = (case when moneygift is null then 
		(0+${fld:payment})::float else (moneygift+${fld:payment})::float end),
	moneycash = (case when moneycash is null then 
			(case when moneygift is null then (0+${fld:payment})::float else 
			(0+${fld:moneycash}+${fld:payment})::float end)
		 else (moneycash+${fld:moneycash}+${fld:payment})::float end)
where code=${fld:cust_code} and org_id = ${def:org}
