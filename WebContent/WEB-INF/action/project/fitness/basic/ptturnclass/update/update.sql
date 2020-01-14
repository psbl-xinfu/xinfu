update cc_thecontact set
	guestcode=${fld:newcustcode} --公司地址
	,status=0
where
	guestcode = ${fld:custcode} and org_id='${def:org}'
	
	
	
	
	
	
