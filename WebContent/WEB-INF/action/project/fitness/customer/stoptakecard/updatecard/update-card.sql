update cc_card set 
	savestartdate='${def:date}'::date,
	stopdays = stopdays + (select ('${def:date}'::date-startdate::date)::int from cc_savestopcard
	where code = ${fld:code} and org_id = ${def:org}),
	status=1,
	enddate = enddate + (select ('${def:date}'::date-startdate::date)::int from cc_savestopcard
	where code = ${fld:code} and org_id = ${def:org}) 
where
	code = (select cardcode from cc_savestopcard
	where code = ${fld:code} and org_id = ${def:org}) and org_id = ${def:org} and isgoon = 0
