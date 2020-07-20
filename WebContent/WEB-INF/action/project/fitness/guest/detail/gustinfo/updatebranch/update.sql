update cc_branch set
	storename=${fld:storenameaddup},
	address=${fld:addressaddup}
where
	code = ${fld:cc_code} and org_id='${def:org}'
	
	
	
	
	
	
