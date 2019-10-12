select
	code,
	classlistcode,
	cardcode,
	issank,
	customercode,
	custname,
	phone
from
	cc_classprepare
where
	code=${fld:id} and org_id = ${def:org}
