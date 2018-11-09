DELETE FROM et_term_item
WHERE tuid in (select (regexp_split_to_table(${fld:id}, ',')):: int8);