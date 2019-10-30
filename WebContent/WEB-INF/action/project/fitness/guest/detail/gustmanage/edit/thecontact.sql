select
  	code as ttcode
  	,name as ttname
from 
	cc_thecontact 
where 
	guestcode = ${fld:code} and org_id=${def:org}
