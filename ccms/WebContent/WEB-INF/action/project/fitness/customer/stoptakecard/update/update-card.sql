update cc_card set
	savestartdate='${def:date}'::date,
	status=5
where
	code = ${fld:cardcode} and org_id = ${def:org}
