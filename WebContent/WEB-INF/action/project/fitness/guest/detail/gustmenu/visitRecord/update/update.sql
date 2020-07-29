update cc_thecontact set
  	name = ${fld:cc_name}
  	,sex=${fld:cc_sex}
	,mobile= ${fld:cc_mobile}
	,positioncode= ${fld:cc_position}
	,birthday=${fld:cc_birth}
	,remark=${fld:remark}
	,possibility=${fld:cc_possibilitys}
	,thecourse=${fld:cc_theproducts}
	,mobile2=${fld:cc_mobile2}
	,branchcode=${fld:cc_branchcode}
	,email=${fld:cc_email}
	,trill=${fld:cc_trill}
	,wechat=${fld:cc_wechat}
	
where
	code = ${fld:cc_code} and org_id='${def:org}'
	
	
	
	
	
	
