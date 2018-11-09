update et_class
set status = 0
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
where courseid in (select (regexp_split_to_table(${fld:id}, ',')):: int8)

