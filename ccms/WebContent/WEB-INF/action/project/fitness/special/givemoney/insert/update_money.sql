update cc_customer set 
	moneycash = moneycash+${fld:givemoneycash},
	moneygift = moneygift+${fld:givemoneygift}
where
	code = ${fld:customercode} and org_id = ${def:org}