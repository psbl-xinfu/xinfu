select
	code,
	classroom_name
from cc_classroom
where status = 1
 and org_id = ${def:org}