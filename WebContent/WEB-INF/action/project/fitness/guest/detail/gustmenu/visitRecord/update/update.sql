update cc_thecontact set
  	name = ${fld:cc_name}
  	,sex=${fld:cc_sex}
	,mobile= ${fld:cc_mobile}
	,position= ${fld:cc_position}
where
	code = ${fld:cc_code} and org_id='${def:org}'
	
	
	
	
	
	