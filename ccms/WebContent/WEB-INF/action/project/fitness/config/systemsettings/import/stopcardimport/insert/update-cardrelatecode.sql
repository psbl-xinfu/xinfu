update cc_card set
	savestartdate='${def:date}'::date,
	status=5
where
	relatecode = ${fld:cardcode} and org_id = ${def:org}
