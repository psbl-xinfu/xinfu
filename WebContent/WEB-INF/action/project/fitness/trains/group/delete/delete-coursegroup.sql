delete from et_course_group
where groupid in (select (regexp_split_to_table(${fld:id}, ',')):: int8)
