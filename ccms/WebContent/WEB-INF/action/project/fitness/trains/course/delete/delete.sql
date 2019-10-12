UPDATE et_course 
SET 
	status = 0
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
WHERE tuid in (select (regexp_split_to_table(${fld:id}, ',')):: int8)

