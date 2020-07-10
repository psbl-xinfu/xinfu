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
	guestcode = ${fld:guestcode} 
	order by code asc
