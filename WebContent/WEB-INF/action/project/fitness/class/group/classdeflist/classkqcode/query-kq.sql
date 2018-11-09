select 
	code,
	rules_name
from 
	cc_classkq
where status = 1 and org_id = ${def:org}