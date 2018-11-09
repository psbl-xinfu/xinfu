update cc_customer set 
	moneycash = moneycash+(${fld:moneycash}*-1.00),
	moneygift = moneygift-
	(case when (select count(1) from cc_chargecard where parentcode = ${fld:vc_code} and org_id = ${def:org})>0 then 0.00 else 
	(select givemoney from cc_chargecard where code = ${fld:vc_code} and org_id = ${def:org}) end)
where code=${fld:cust_code} and org_id = ${def:org}
