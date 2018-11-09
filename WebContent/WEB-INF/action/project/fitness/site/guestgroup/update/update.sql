update cc_guest_group set 
	groupname=${fld:groupname},
	updatedby='${def:user}',
	updated={ts '${def:timestamp}'}
where
	tuid::varchar = ${fld:code} and org_id = ${def:org}

	
