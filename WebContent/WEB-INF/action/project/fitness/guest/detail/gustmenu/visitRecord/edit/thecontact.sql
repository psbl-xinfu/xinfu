select
  	code as ttcode
  	,name as ttname
  	,sex as i_sex
	,mobile as vc_mobile
	,(select code as poscode from cc_position where code=cc_thecontact.positioncode)
from 
	cc_thecontact 
where 
	code = ${fld:code} and org_id=${def:org}
