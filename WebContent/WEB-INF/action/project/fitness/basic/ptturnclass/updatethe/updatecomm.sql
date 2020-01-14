update cc_comm set
	guestcode=${fld:newcustcode} 
where
	guestcode = ${fld:ccguestcode} and thecontactcode= ${fld:thecode} and org_id='${def:org}'
	
	
	
	
	
	
