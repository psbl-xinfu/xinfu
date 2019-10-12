update cc_guest_group set 
	status = 0
where
	tuid = ${fld:tuid} and org_id = ${fld:org_id}

	
