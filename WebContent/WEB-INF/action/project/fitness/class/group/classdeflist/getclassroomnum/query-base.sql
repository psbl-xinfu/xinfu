select
	limit_num
from cc_classroom
where code=${fld:code}
 and org_id = ${def:org}