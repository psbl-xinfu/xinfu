select
	classkqcode
from cc_classlist
where code=${fld:code}
 and org_id = ${def:org}