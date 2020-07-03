select
  	 code as branchcode,
	 storename,
	 address,
	 states,
	 createdby,
	 created
from 
	cc_branch 
where 
	guestcode = ${fld:code} 
	order by code asc
