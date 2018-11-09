select
	code,
	rules_name,
	isrules,
	percent_value,
	fixed_value,
	remark,
	status
from
	cc_classkq
where
	code=${fld:id} and org_id = ${def:org}
