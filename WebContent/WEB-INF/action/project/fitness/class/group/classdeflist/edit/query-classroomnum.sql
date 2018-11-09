select
	limit_num
from cc_classroom
where code=(select classroomcode from cc_classlist where code = ${fld:code} and org_id = ${def:org})
 and org_id = ${def:org}