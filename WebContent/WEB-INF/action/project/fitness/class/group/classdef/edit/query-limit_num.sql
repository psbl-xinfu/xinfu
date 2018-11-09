select
	limit_num
from cc_classroom
where code=(select classroomcode from cc_classdef where code = ${fld:id})
 and org_id = ${def:org}