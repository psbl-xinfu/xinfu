select
	code as tuid,
	name,
	mobile,
	sex,
	age,
	intention,
	isaddwx,
	communication,
	remark,
	(case when createdby='${def:user}' then 1 else 0 end) as type,
	demand
from cc_guest 
where code = ${fld:tuid} and org_id = ${def:org}