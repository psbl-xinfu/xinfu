update cc_public
set status = 1
where guestcode in (select regexp_split_to_table(${fld:id},',') from dual) 
and org_id = ${def:org}