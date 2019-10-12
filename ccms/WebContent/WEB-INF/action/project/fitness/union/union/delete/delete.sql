update t_union 
set status = 0 
where tuid::varchar in (select regexp_split_to_table(${fld:id},',') from dual) 

