update cc_thecontact set
  	name = ${fld:cc_name}
  	,sex=${fld:cc_sex}
	,mobile= ${fld:cc_mobile}
	,positioncode= ${fld:cc_position}
	,birthday=${fld:cc_birth}
	,remark=${fld:remark}
where
	code = ${fld:cc_code} and org_id='${def:org}'
	
	
	
	
	
	
