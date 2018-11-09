update cc_site_timelimit 
set 
	choose_way=${fld:choose_way},
	updatedby='${def:user}',
	updated={ts '${def:timestamp}'}
where
	code = ${fld:site_timelimitcode} and org_id = ${def:org}
	and ${fld:choose_way}!='0'

	
