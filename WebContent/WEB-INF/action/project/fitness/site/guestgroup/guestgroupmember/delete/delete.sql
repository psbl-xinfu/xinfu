update cc_guest_group_member
set status = 0
where tuid::varchar in (select regexp_split_to_table(${fld:code},',') from dual) 
and org_id = ${def:org}
