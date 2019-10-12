select 
	tuid,
	course_name,
	course_desc,
	termid,
	created,
	createdby 
from et_course 
where tuid = ${fld:id}
