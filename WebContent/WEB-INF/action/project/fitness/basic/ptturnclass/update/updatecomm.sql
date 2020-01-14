update cc_comm set
	guestcode=${fld:newcustcode} 
where
	guestcode = ${fld:custcode} and org_id='${def:org}'
	
	
	
	
	
	
