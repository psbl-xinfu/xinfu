update cc_guest_group_member set 
	guesttype=${fld:guesttype},
	pkvalue=${fld:pkvalue},
	updatedby='${def:user}',
	updated={ts '${def:timestamp}'}
where
	tuid::varchar = ${fld:code} and org_id = ${def:org}

	
