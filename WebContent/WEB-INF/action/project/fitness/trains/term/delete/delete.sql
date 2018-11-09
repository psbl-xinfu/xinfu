UPDATE et_term SET
status=0
WHERE tuid in (select (regexp_split_to_table(${fld:id}, ',')):: int8)