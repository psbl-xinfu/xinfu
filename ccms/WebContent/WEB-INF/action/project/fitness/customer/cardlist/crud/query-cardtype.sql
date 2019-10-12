 select
 	code,
	name
from cc_cardtype
where status = 1 and org_id = ${def:org}
