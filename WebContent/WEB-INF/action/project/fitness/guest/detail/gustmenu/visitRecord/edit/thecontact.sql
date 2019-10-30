select
  	code as ttcode
  	,name as ttname
  	,sex as i_sex
	,mobile as vc_mobile
	,position as cc_position
from 
	cc_thecontact 
where 
	code = ${fld:code} and org_id=${def:org}
