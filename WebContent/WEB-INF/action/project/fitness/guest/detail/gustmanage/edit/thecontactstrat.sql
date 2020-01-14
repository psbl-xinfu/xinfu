select
  	code as ttcodestrat
  	,status as ttstatus
from 
	cc_thecontact 
where 
	guestcode = ${fld:code} and org_id=${def:org} and status=1
