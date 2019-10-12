delete from et_course_group
where courseid in (select (regexp_split_to_table(${fld:id}, ',')):: int8)
