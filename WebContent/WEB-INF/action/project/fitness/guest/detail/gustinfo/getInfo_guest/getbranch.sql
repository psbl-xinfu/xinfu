select
  	 code,
	 storename,
	 address,
	 createdby,
	 created
from 
	cc_branch 
where 
	guestcode = ${fld:id} 
