update cc_guest_group set 
	groupname=${fld:name},
	updatedby='${def:user}',
	updated={ts '${def:timestamp}'}
where
	tuid = ${fld:tuid} and org_id = ${fld:org_id}

	
