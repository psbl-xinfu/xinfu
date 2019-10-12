select
	name as cardtype
from cc_cardtype
where status = 1 and org_id = ${def:org}
