select
   code
from 
	cc_customer 
where 
	mobile = ${fld:mobile} and org_id=${def:org}
