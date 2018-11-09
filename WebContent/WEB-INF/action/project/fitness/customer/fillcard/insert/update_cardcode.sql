update cc_cardcode set
	status=0
where
	cardcode=${fld:cardcode} and org_id = ${def:org}