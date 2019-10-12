update cc_cardtype
set status = ${fld:status}
where code in (select regexp_split_to_table(${fld:id},',') from dual) 
and org_id = ${def:org}
