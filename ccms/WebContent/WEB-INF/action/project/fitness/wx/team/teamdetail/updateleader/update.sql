update cc_guest_group set 
	leader = ${fld:leader}
where
	tuid = ${fld:tuid} and org_id = ${fld:org_id}

	
