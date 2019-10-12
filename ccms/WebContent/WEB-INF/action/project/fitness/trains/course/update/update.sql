UPDATE et_course 
SET 
	course_name = ${fld:course_name}
	,course_desc = ${fld:course_desc}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
WHERE tuid = ${fld:tuid}
