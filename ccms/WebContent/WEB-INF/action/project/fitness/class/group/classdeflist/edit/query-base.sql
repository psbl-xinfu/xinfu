select
	code,
	classcode,
	classroomcode,
	teacherid,
	classdate,
	classtime,
	status,
	remark
from cc_classlist
where code=${fld:code}
 and org_id = ${def:org}