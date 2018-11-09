update cc_card set
	status=1,
	startdate = '${def:date}',
	enddate = '${def:date}'::date+(select daycount from cc_cardtype where code = cardtype and org_id = ${def:org})
where
	relatecode = ${fld:cardcode} and org_id = ${def:org}
	and isgoon = 0