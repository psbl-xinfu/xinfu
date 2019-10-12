update cc_fillcard
set status = 0
where code in (select regexp_split_to_table(${fld:id},';') from dual) 
and org_id = ${def:org}
