select
  	code as ttcode
  	,name as ttname
  	,sex as i_sex
	,mobile as vc_mobile
	,(select code as poscode from cc_position where code=cc_thecontact.positioncode)as poscode
	,birthday
	,remark
	,branchcode
	,possibility
	,thecourse
	,mobile2
	,email
	,trill
	,wechat
	,guestcode
	,(select officename from cc_guest where code=cc_thecontact.guestcode ) as theguestofficename
	from 
	cc_thecontact 
where 
	code = ${fld:thecode} and org_id=${def:org}
