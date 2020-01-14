update cc_thecontact set
	guestcode=${fld:newthecode} --公司地址
	,status=0
where
	code = ${fld:thecode} and org_id='${def:org}'
	
	
	
	
	
	
