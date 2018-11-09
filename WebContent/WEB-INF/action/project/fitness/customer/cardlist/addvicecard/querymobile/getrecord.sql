select 
	count(1) as num
from cc_customer
where mobile = ${fld:mobile} and org_id = ${def:org}

   