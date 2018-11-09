update cc_savestopcard set 
	status= 2,
	enddate='${def:date}'::date,
	updatedby = '${def:user}',
	updated = {ts'${def:timestamp}'},
	factstopdays = '${def:date}'::date-startdate::date
where
	code = ${fld:code} and org_id = ${def:org}