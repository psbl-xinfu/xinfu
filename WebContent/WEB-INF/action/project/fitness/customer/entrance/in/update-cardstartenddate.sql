UPDATE cc_card set
	status =1,
	startdate={d '${def:date}'},
	enddate=({d '${def:date}'}+(totalday||' d')::interval+(giveday||' d')::interval)::date
WHERE
	code = ${fld:cardcode} and org_id = ${fld:unionorgid}
	and status=2 and starttype=1